<?php
/**
 * Helper class for getting and parsing uther.tube/uthertube/ut stuff
 * written for PHP 5.3.3 compatibility, so no [] for arrays :(
 * 26 Feb 2023 - started this cause memories should be forever
 */

class Uthertube
{
	/**
	 * Grabs data from /api/VideoXML and parses into "meaningful" (1:1) json
	 * 
	 * @param string the magical ID that references a video
	 * @return string parseable json
	 */
	public static function getVideo($id = '')
	{
		if ($id == '')
		{
			return '{}';
		}
		$xml = self::getURL('http://www.uthertube.com/api/VideoXML.aspx?id=' . $id);
		if ($xml === false)
		{
			return '{}';
		}
		try {
			$options = new SimpleXMLElement($xml);
		} catch (Exception $e) {
			return '{"error" => "data not in xml format"}';
		}

		/* Do we have an error passed from /api? */
		if (isset($options->error) && (strlen(trim($options->error)) > 0))
		{
			return '{"error" => "' . $options->error . '"}';
		}
		$video_keys = array('url', 'src', 'autoplay', 'videoid', 'guid', 'friendlyguid', 'title', 'dateadded', 'rating', 'starttimecode', 'videobitrate', 'audiobitrate', 'profilename', 'videocodec', 'audiocodec', 'width', 'height', 'quality', 'popups', 'overlaylogo', 'forceaspectration', 'specialpromo', 'registered', 'payouttrigger', 'referer');
		$video = array();
		foreach ($video_keys as $key)
		{
			if (isset($options->video->$key))
			{
				$video[$key] = (string)$options->video->$key; /* String recasting is so cheesy */
			}
		}
		$post_roll = array();
		if (isset($options->video->post_roll))
		{
			/* There should be 16 but we're not counting */
			$idx = 0;
			while (isset($options->video->post_roll->Video[$idx]))
			{
				$roll = array( /* ternary hell */
					'title' => isset($options->video->post_roll->Video[$idx]->Title) ? (string)$options->video->post_roll->Video[$idx]->Title : '',
					'rating' => isset($options->video->post_roll->Video[$idx]->Rating) ? (string)$options->video->post_roll->Video[$idx]->Rating : '',
					'thumbnail' => isset($options->video->post_roll->Video[$idx]->Thumbnail) ? (string)$options->video->post_roll->Video[$idx]->Thumbnail : '',
					'url' => isset($options->video->post_roll->Video[$idx]->Url) ? (string)$options->video->post_roll->Video[$idx]->Url : '',
					'views' => isset($options->video->post_roll->Video[$idx]->Views) ? (string)$options->video->post_roll->Video[$idx]->Views : '',
				);
				$post_roll[] = $roll;
				$idx++;
			}
		}
		$video['videos'] = $post_roll;
		return json_encode($video);
	}

	/**
	 * All-encompassing cURL to get something from an endpoint.
	 * 
	 * @param string a URL to get
	 * @return string|boolean
	 *         string, data returned. either a webpage or xml or whatever we asked for
	 *         boolean, probably false which means badness happened
	 */
	public static function getURL($url)
	{
		$ch = curl_init();
		curl_setopt_array($ch, array( /* This is why we create 1 function to do it all: https://www.php.net/manual/en/function.curl-setopt.php */
			CURLOPT_FOLLOWLOCATION => true, /* not sure if we need it but we need to get to our destination */
			CURLOPT_FRESH_CONNECT => false, /* limiting system resources if we can */
			CURLOPT_HEADER => false, /* Only need body */
			CURLOPT_RETURNTRANSFER => true, /* return actual data */
			CURLOPT_SSL_VERIFYPEER => false, /* in case of ssl certificate expiration or hostname/sslv3 mismatch we keep going */
			CURLOPT_CONNECTTIMEOUT => 5, /* connect in 5 seconds or less or the pizza is free */
			CURLOPT_MAXREDIRS => 5, /* typically set to about 30 with _FOLLOWLOCATION, i'm sure if we redirect > 3 times it's a problem */
			CURLOPT_SSL_VERIFYHOST => 0, /* don't really think we'll get MITM'd, so we save processing */
			CURLOPT_TIMEOUT => 10, /* 5s connect, 5s everything else */
			CURLOPT_URL => $url, /* self-explanatory */
			CURLOPT_USERAGENT => 'uther3d/1.0', /* identifier */
			CURLOPT_HTTPHEADER => array( /* more headers per requst */
				'X-CheckOut: https://uther3d.com/uthertube', /* silly callback */
			),
		));
		$data = curl_exec($ch);
		curl_close($ch);
		if ($data === false)
		{
			return false;
		}
		return $data;
	}
}