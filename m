Return-Path: <linux-edac+bounces-2142-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACB9A4746
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 21:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AA81C20936
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774B205AA5;
	Fri, 18 Oct 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzc4Ubbe"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031B757F3;
	Fri, 18 Oct 2024 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280655; cv=fail; b=AEc3rJF3U0KnQqdGdl9i+RBGX2fZNNf197BJPe2xAWzko5ZRFFPNJo7QCNWNLwPcuQsasGJFvtLOkoF8ZtjWqs759Q7QKHqSoIV5b0PjE+w4SD2VePMims9zSMNICtz9MuevGwLxK9skhSBcUxqR3gnq0iihMNupx+rO521nQBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280655; c=relaxed/simple;
	bh=tUdRHQCf+xHLiDmwRi37Ag8InGXYbrVNZtYgmehbpYM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEQ/VzMQhTiU+3B4uh60ZdFP/+ta8oXuzp93bLuu0xeS88Cb2U5YEWm32dwsBZDNomz733NONTpfs1AfDcNi6t8W/0aJ0p/po5XvT96hL1kQj7RmHfShUI6NF85YvypE+WW3+mv0mNPAj8anQOR+zDSqpLl8W2I9+uqRA5zfg88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzc4Ubbe; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729280653; x=1760816653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUdRHQCf+xHLiDmwRi37Ag8InGXYbrVNZtYgmehbpYM=;
  b=gzc4UbbeyYYlOLWPbrgXK9AdtAjr5/iy9CwcpQ/ip2GOtjWzDTbDvJIU
   DOJ3nE/swa1jLoFeRuA0YtZtwwCyUM6e24LrA2D6noso82YxDcMdHapsE
   fbUCwFWT0O+4Hwhy5JCn/IPjQh4xtJbUEnZz7dppOHTSCDsy++hy7z9mj
   LPZI00/MJyya9VepD+KV5I19JJWF5a3T25i5oYKWgY48atg0ZZqxZ7SHg
   AtSDMKCRWehXjHFtQIJd1xSgIuSCQbbRoxATewaktvUMIa5/b+QLFDFuk
   hMouAnzJ7ibLz9zOsVn/EqjMqMT8omoyi2DtuptYqbFc3pBvpHuueCIUa
   Q==;
X-CSE-ConnectionGUID: dbxoUtFrQ1GKZScAoG+Pfg==
X-CSE-MsgGUID: 6oIv8GnwRtmwnGo873Pk1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28704293"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28704293"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:44:12 -0700
X-CSE-ConnectionGUID: +cb+R7taTCuYoNHqGxZsPQ==
X-CSE-MsgGUID: 9VJYOWrfToOjIRRfStJYPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79017347"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 12:44:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:44:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:44:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 12:44:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 12:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkHOOoGdyITuG/k33o+brf71oroFdxPTu6klKHEyXZhdUrSl8B0hn7PneX7EXaoJRdfXVX9vWyz4r4hQ8l1sdXnwjmQLJK4flmdvDttu4oNZVfZgu6iAMth5dkL5HxETWwP5td+22lSHunwGkmOzczjoofWVUmDwLv3Qx2onnd7OgPSk81E4Ww4WDB6tL8Zq3zFnl8dsGtvVBjXsqNY0BYq9+U62/chfii6ZjVw7BtpyNw3Leoywm3bgDePMBjvFNzxJHXw/OPdhUyETNkBzUg+MGqvIYoeIrHtfAdCjUQ8BupkftJWKVrZdu5vJrN/oGWmrgqBYmByHLjd0Pcg2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eOB404MZ7WjQc2ZmaPPsv+jNcCfkvS8WKU1X9MBJ7M=;
 b=mTM5RfhV01CE+iWnBTiuy35sk38L2EsytJfsquKG6ihGjuJ9gJvV9ariotVshxdpHbwa8DVGVEhYSFa3hS8RvieMzoGNPLf3MLkmNp24lHFJ3qPWxJve2Lj3Z+bJ5+525MMmLB+yDBxs+i7ylVeKk1wH+rzjmQwJssLaIe0MzzpBeYG3MCsq2u6Bw36K5d7rfvH3GTm9E+UAv7og7AlNZsLl20Gqcdo/s5sXOaLRhiViMnBCbk4IdFnrwarV8L+spM1k9YLUYDY21mnbJBksNWCHwQyD2fNUBWva/b2ml3xZDn3yzbRJhuWhxeCf2bFgqtcZSpP+diFV3XjxMpk8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB6101.namprd11.prod.outlook.com (2603:10b6:8:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 19:44:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 19:44:00 +0000
Message-ID: <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
Date: Fri, 18 Oct 2024 12:44:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-7-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: a1127c8b-a1d0-4daf-c18e-08dcefad36cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDlkc2Q4NHNKVWx6dHF0WmpJcTRWcVpneXl2TW1KLzRQSXVDTHRlQlJKbHh6?=
 =?utf-8?B?cHpGUHlWam05cEY0VHpsejJDTEZpNzZoWnJiazVvQ0NKZElwSnVTRHIzNWE1?=
 =?utf-8?B?eXBTeVhZUkxXVEd6eU5sbXB0a3ZFL3BEbkVKbkZNYXJCZlpCTXJGK1JOV01X?=
 =?utf-8?B?alhQQzVnY2ttd2thQk12S3ozOGtNR054MlUyb1BaZ2F4NzRqeXFtY0VUdDM0?=
 =?utf-8?B?dmJnRkdkQVRoRThScEpKa3JuK21FMExvRjc3L1VNR3dSSVJkMFJXZVg5ZXFv?=
 =?utf-8?B?SkpDS0hvUVRWblM0djRmbUVTODhwdE44NUxzMlBEVHhJSDFrQlVqeHlqRjV3?=
 =?utf-8?B?VXBMSDlJZUtRNjRKUWVacVNXWTAxWCt2SVhxWFZOWkdlOGJqNi80U2J4VVJZ?=
 =?utf-8?B?MHQ5QmdoeWRUOVNvNkFaQ29McnQ1Qk1td0xoU05DRXZhUlNydyswSTlsNmpK?=
 =?utf-8?B?QjJGZjhVM0RYamMrTmVjN09Cek90WTYzTHJidzR4R0lLYUFtVDd0OThQUlF4?=
 =?utf-8?B?NTNYWk0wbU1YUDNIQ0ZVTTc3OWI1VU0zSTd4TFgzSUlSb3lqQVhXZUNoNm5s?=
 =?utf-8?B?Z2VKRnBjY3RRaE52LzBzUWxqVDJhcjBveGt0MnF5eFU1bVBCS0NKTDFTVm4w?=
 =?utf-8?B?UzV6SlVtaG1LdG4wRDZpYUdpUkJpaVVhQkR2T0wvaEZvUFY3UDVYNFEyaXQ5?=
 =?utf-8?B?aTBWVWQ3bE5GM0N1ODJHMzN5c3E0QTBRalFXVk5GWGtFaWtpY3NOL3pOVU52?=
 =?utf-8?B?L0gwMEdvZ0VxSlBnL1U0eEQxQkY3ZkdNUEJlRXlFUmowSFkvZ0kvc2IzZC92?=
 =?utf-8?B?ZU1md0x3Qk5GTSt5UHBBcUVaSmRVWi9RUUxyMGR0ZGhtTEE1dUgyWElTZXYr?=
 =?utf-8?B?b3FCdUdJdnVTY2p6MVB3SzRrNVZxZGVZNS84bnE0c2lxUVBPUnFYR2ZpNkg2?=
 =?utf-8?B?UCtlM2tBQjIyd2NyTVh3M2tWMDI2bWZEMkVLdXNtaER6SUFrWlAxS093dXRY?=
 =?utf-8?B?U01VcnlSNVhFdGo1TUpQUEl3SGpEMlZvdzZQcEdBNldZTi9FdXFHWnhlZEZh?=
 =?utf-8?B?YWFKdk5IdDR0aStlZ1pLbi9LWE9uUDRWb2VnM3piTFd1WFFjRnhpTEl0Y2ZG?=
 =?utf-8?B?L1BLV3FiYjNxdjczZXl0SDJsVG0zb3Q5UEFZT3g0S2dERnMvY0dQNHlTOEsz?=
 =?utf-8?B?M3dqVnZZblhicUdITmlJTUlEMElJbHNyYWZKV2s2L0J1eFVnekxISlVSeEpt?=
 =?utf-8?B?OHZKKy9MM29NVWxFcER5L1VycXBRMkFaN20xaThja29wWFRuT2UrZkRYOEZS?=
 =?utf-8?B?eDBBNTU0bDZNZlVpWGVOQjNZV203NERlcnBoYzEvc0Q2RkRVRnJRMzNKS1By?=
 =?utf-8?B?SjZJZ0x4TlRJZjlJQW1ZZVBtOU5ReDh2ZGVmM0JaUEFSNGR6My9RRDRmV2dX?=
 =?utf-8?B?L0dudjQ1VkN4RkowYzVpdmxOTkd6MVNYZlpLbXhTQzlhTlExTk1kNGI2endV?=
 =?utf-8?B?NW9TRVk3VTl6cjNydkNWdks5MUVDWWU3MWduYWlraTlvc2tuWDlObHpFMWRR?=
 =?utf-8?B?a205YjZCQ0J5L2pXMGdnSFpQSjlBSjBDVW1kdFlpbytLenRTWWw1dy9xYWlo?=
 =?utf-8?B?WlR4ZU4xRGR2dHltMnFxY0l3bUtxQU80NllIVkJOOUkwcGhISUMxaE40K3dj?=
 =?utf-8?B?Uit4QWVqd2JKb2FlUnEycE5BcTF4NW5yWkd4cFZRaEM2YnZUNWNUNlJER0NB?=
 =?utf-8?Q?2dsaHuH0vKfBmYqPpbxKskAg9Tlf4v+ZR6Zji7k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZ2dGdZK3Z3cERGV0Q5OFpLaTNVcktoSUc4LytzQko2SjZWOFBZM3BYU3cr?=
 =?utf-8?B?djFrd0cyMXNBdG1KNytaL21uWWVtTDlFTHA5S3A0MlhiZVY3R3BsYkQ5cmNH?=
 =?utf-8?B?L21BaVRYVDRtZk04WDJwbitENjd5N3V2cGMwdGM1NTdKclB4Q2o0VXlTcVJB?=
 =?utf-8?B?OFZCN1NWc2JiU3VqZkczVUtnU0Fzc2lsa005RDlCOXJ2eUZlNXdPamMrMWxr?=
 =?utf-8?B?dy9iR0diSXBSVU8xU2NDRUREK21yM1d2UGN2czBMRDhSam5sZ3lRQSs0T1Jv?=
 =?utf-8?B?Q2Y5a243MmdKRGppdlFzTG5RNGl4Zk9EdmFjWnBnTlhZc0Uxcy9UMzZXUHJS?=
 =?utf-8?B?ZTd0RWlDQVRIL3U1eks5a283MVN5ZFBwMi9ub1RZVVBhRHRvVWV4ZC9icjli?=
 =?utf-8?B?Yit3dS9KNlg2a3VqTnlhN3ZwMzI3OUxPNzJOYU9WV2N5NkNtWHlWNmRZb2Er?=
 =?utf-8?B?WmVxYnRnZlZnOXZEQkdGekVUK3lNL05wNjl4T0JqNVFKZDlMelNmNmp6YjNU?=
 =?utf-8?B?VjFMem9LVFcwL1RBMjAybmZvdTJ1Z000WXlrRzdFR3hVT0FXUUpuNVRNd0Fz?=
 =?utf-8?B?eGlaYkk3QjdXYVd1YXF4ZlFjRmlrelNnTXJldHJvTjdzdk9JT0o3Q29acURE?=
 =?utf-8?B?NzlENVRxbWlzd3hoRCtZcW9kYVNEeEkxK3FkRTg5Y0U5QjhDakYvbVdTS3lL?=
 =?utf-8?B?UGJRVkYyenZXRVpUVlAvTXMreURQSXN2VkN5ZHkvNko4dWtRcWZDTzh1ZnBs?=
 =?utf-8?B?RE5QSjlscFM2TERCQmFGbmViRzlBYkFSa2s4b1ZoRzJwMVorRmt5TXQ4N2VG?=
 =?utf-8?B?SEQ1Sk52RDVEUXplTG90anBLWmY4ZkhWWWJVY1p2ckNtbjR4ZG13KzR3b1hY?=
 =?utf-8?B?OEl4M2hSL0c5dUNQL0dSZWFYMHJtTXM5SGxZd1ZPNHpCU09jS3FxZFc2SDVZ?=
 =?utf-8?B?YzBKb1hRZXZJSHdQbjlwQUJ2K05zODVrSkxUSlBvd3pWQTNwTTQ2a01VR05W?=
 =?utf-8?B?ZDVKdW5sQzZqbEJtZFFadVRlcmxNU2kxRHpzdDdzbktINnVrOFp1b0Uydkkx?=
 =?utf-8?B?a0pnQzNpUURrV0pOZWVVMEhIem5DRmNZNjlRMXBXaUtIcnpKQVNYYm5iOGRs?=
 =?utf-8?B?cHBjdEhJd3pKN05IYzFFNndsenBwTzhIMzk2clFicThVTTV2MDRGNklpRG9o?=
 =?utf-8?B?OHdxclNNUExmak42Skt2dlJzMlczM2RNYkhSZSt0b0Q1YW1XRTUxbXovMXdH?=
 =?utf-8?B?UWtqSVJwb0lhZTc2TkY0Ulp3cWRhR2tMT2JiVTZUT2ZCL095WC93a3BLTGpJ?=
 =?utf-8?B?VTNTZ1VBOXhPRlV2cmwrYTlYRkhoR2N5OTM2WlVRVFlTdnJ2LzdCUmhHNGpC?=
 =?utf-8?B?N2Y3N3FoV3dvemN1cmkybjF0QWgrSkdaNmtDN0NqWW9TWDFVYVh2dmNBNWF0?=
 =?utf-8?B?QlN4UmREekhqNHhxVlVTM1RoOFlCNWkxSEpKcEhaQ2NRU05BeGUydHNhMll3?=
 =?utf-8?B?SXBLemdLRmtpb1hQU2dHazRJeWtha21aVEx1bFo2WXV3MEpiM2xVam5MQ3hF?=
 =?utf-8?B?SVU3YzNMRDczdTFuYzM1eDh3T3A3TFdZcGJKYnlVKzhPSkpLbDhUeU40aTFt?=
 =?utf-8?B?SUpCbVRBa3JxbC96cHhodk5VbzRnUGNUZTVQM2hnckkvakZSdzhrZzlYUXZs?=
 =?utf-8?B?cWExdjNVUm1INzk0V3NQeHAxeTRiK0E5NGRtSVhydlFoakMwVHdISUtsZ29X?=
 =?utf-8?B?Yms2b2g0Wlhvck1tVTE3NEtvVHBPRzFtYStzbjlSUnVCY2p4Tk5rZTNVYjdk?=
 =?utf-8?B?a0Q5TEwvWDk3SnhGU2RScWZ0WDNoWTdCd1dIR1NuK0E5ZWhlQUNaWHRTT0g4?=
 =?utf-8?B?a205S2EzcjZWNlBrWE1Gc0xqL1YxMlZhTnpMck5XSXFVZVVTOHAyV0lSeGUx?=
 =?utf-8?B?blA1STQ1QUNIVWhldFQ4ZldkQWtweEQweExiQ2R0QkZGcU5lZTNHdEZCbk8y?=
 =?utf-8?B?bG81WGlncFpjd2FhTFlHcEdSYzd4dE9EY0M0Nm5EaFpYVGtJWUNLK25haGNZ?=
 =?utf-8?B?eGtWK0FSVWRqZTdZREhzNUNuUzhqS21PT0xSbTdPL0ZWaGhDM0V6R2x2N29M?=
 =?utf-8?Q?x4fr2M/MCNAw/XPwbvdVqz64x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1127c8b-a1d0-4daf-c18e-08dcefad36cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:44:00.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch8+XbTUHM8Lxxii6PwCjxYgk/YYXRr0oVAJNx1TOfjo1ftXrhG3XI3dcHhtkHUsLesz0Jf3B8c3AzLOYndphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6101
X-OriginatorOrg: intel.com

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 725c1d6fb1e5..40672fe0991a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1892,7 +1892,8 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  	}
>  
>  	/* This should be disabled by the BIOS, but isn't always */

This comment is specific to the AMD and placing it before the switch
makes it seem generic to the entire switch statement. It should probably
be moved inside the AMD case just above the disable GART TLB check.

> -	if (c->x86_vendor == X86_VENDOR_AMD) {
> +	switch (c->x86_vendor) {
> +	case X86_VENDOR_AMD:
>  		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
>  			/*
>  			 * disable GART TBL walk error reporting, which
> @@ -1925,9 +1926,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
>  			mce_flags.zen_ifu_quirk = 1;
>  
> -	}
> +		break;
>  


Also, why not include the unknown vendor check (right above) inside the
switch case as well?

if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
	pr_info("unknown CPU type - not enabling MCE support\n");
	return -EOPNOTSUPP;
}

This seems to follow the same pattern as others and can be the first
case inside the switch.


