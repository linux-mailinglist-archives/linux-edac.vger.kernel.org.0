Return-Path: <linux-edac+bounces-2500-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92179C4C9D
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 03:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B4A1F2148C
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFB55C29;
	Tue, 12 Nov 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0KSvu7N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE06F4F1;
	Tue, 12 Nov 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378690; cv=fail; b=Cg9jz7d3ic3OJ+B4vGHgTmj5J6l+SyasaFF6MenCbGBNt/YVQqziHQsT9RZD+ggrUOc1xhePY6q3Ns9M66tmh8hzq5asYCnpwWhUQbYqkzrwq/a1wWNzSsgaU19LeDeo/SyuI/Cq1PfHf06zfI7o/CcerlMHzR6cMMqTJfrJNoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378690; c=relaxed/simple;
	bh=upMmMMHTpKkWY/IkNCphcXi7GuMHjoPMGMyh8Skyrtc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u32Ffh5bDrSJoCETKJKxVoBZm/MZOGUOUok2fvbmO4ve8gIVa1KBt/s+xhdoKNkyckWPARHX4yBynMhfb+ufYs91/UqWYzmgyrF7WIR8yl1BANN9KtzcrmZ+KvdT5gHG49sQ7jHky6HHIlCjVTzUOwmtVpp5z4oeGXlI2uzUaaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0KSvu7N; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731378687; x=1762914687;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=upMmMMHTpKkWY/IkNCphcXi7GuMHjoPMGMyh8Skyrtc=;
  b=c0KSvu7N2kHosJH/CUVf+HAvcsKETsFZCIOIPyxSsv9K6qLxFtGLmLSH
   1Q2AI+W7J61tu31gHlZ/grxBLCwU2szoMH2o3uEkm5nVEc/VheqqFzebz
   Ub+9HECtdav3Tncf8mf6ze5lC5hwkxtIvKSPYi4hhG6NIKifJl+G69UJ9
   Y2ZSquoctC7j3saVhY/6VsuG5iCatiUSsjWaiZDavts2eLp9Kuqx4bbCz
   Rl+5RtY2irprJtMzgIrAQQopxo+B3tGb23OUM3xGyI8pmeua6Qt6OmYPR
   iE4SAD9qfzbjqLPwk1fDJ8cMrw2RUftZWK5D33NUphcRoUOW/PYHXiPIF
   g==;
X-CSE-ConnectionGUID: b8voE247QnGGshrpPF6qWw==
X-CSE-MsgGUID: 5GmenAGXQkWplN51z6xMDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30598843"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="30598843"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:31:24 -0800
X-CSE-ConnectionGUID: BJPhOB6PQg+75yAB2tZa8A==
X-CSE-MsgGUID: FNuFcDh0RtGjLqQvO8QF3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="92150563"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 18:31:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 18:31:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 18:31:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:31:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTplLgRPac8aJSJKRRsFtScoFjQPPVOCIVjxyw3kdd9ciQNdL/+vmgRkvJLI5dentAdZtVQfH9quGy0m9/jmh2LD0zp8RzjifuhEQzVLxSpRy/8J+Lyni+Njpzd+BFxGbDJGsIMkY5cR1c5jlhkhF6h9qD07Zpr8lpdlRSoI9Ef64+0Ky3/IXi7l4LUR5XwEgxjujQ3N8oAQvdXR1+msVLGXO9fXuINxRprZSbYiXKXdSUUqzg8mWRjQTFN7d0r4bnl7ZoiMP4GqVv1Ei4fsagq/jEUwcIuRS44Reh1RwxoT8CFNqzUHH5uulbza7VCwknqNRvWswHnA4hnDnkPyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmol4cupf4ZWOmpQMHEpYN93LuAVP8euYUK+Nce1t8I=;
 b=hHw9fLjWgUM69BUv6WP5GgVGRNcIWQbnGCAJWkQj3SVQjCzm1mQkS1w0IsxgsiV/qra8pUMv3d5qKJJuI3Z2j537+DhQq4yyOErclbXi7sPzaZS9/5uizpDBNSXZnkkl3r4L1Pp0f8IBicVQeVKrBrZaxYvfu3VBtTu4aknee1eNLEdxivldheh/MKFukPwC2U3Pb07a2YgDk03ZlV0crdRLdXf5cSzyghXyhaKYo9IlunXYQQE3vxoNhMmAi+nvVAIv7oqRpiVNIoE9zzzHxuZiEppcNiYBnq1cCGoHjYIQ6IK7wu+0QahkS+SRgZokraAGtMZ5EuRJCAL2wMxhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:31:22 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Tue, 12 Nov 2024
 02:31:22 +0000
Message-ID: <7082d4d4-e7b0-4111-88ad-dbadff44ae7f@intel.com>
Date: Mon, 11 Nov 2024 18:31:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] x86/mce: Break up __mcheck_cpu_apply_quirks()
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <tony.luck@intel.com>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <yazen.ghannam@amd.com>, <nik.borisov@suse.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-5-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241111060428.44258-5-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e87cbe-36a0-436e-4562-08dd02c218ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0g0ei9tOW9zblZHdnJldlE4V0pUbFVHQkg0eVZ6YnIxTm0wK0w4YjJUNnhM?=
 =?utf-8?B?UVkweXMvZzNrMlFxQmtQd3Q2VHZLYmVpVktLNWlGbHJsNkhRemlBMGt4VXJM?=
 =?utf-8?B?UnpSd2p3b2pVSEVvemJlYnpDa0JYSGpJSWNhQWkzMVRQRmU3bkhneklzRU95?=
 =?utf-8?B?ZVJJSVhxWUNrUHdBTFE0eEFzMUU2MVZaSU1yQ3NEQTU5RGNmT0VGTzFxY29V?=
 =?utf-8?B?NTRocjdFbjVOQXVETVpaam9xZGZJaWthVDZPamtpb1Y0Z0ZDakUrMHlDZldJ?=
 =?utf-8?B?Uk01Sk9kYmo1bmdmaVhxWUFiOHhYOUJ6dG9kWW50ZlJGd2lPa3o3Njd0aUI4?=
 =?utf-8?B?S3dHV2FQVmxvYjBRNlpHS3hPL3ZVak9wOUtPZUhUZHY2dXYrdWxtenJvV1kw?=
 =?utf-8?B?OVBjS0F1MjBiK1RPZlhudVh4Zy96a1Fqd29rWE8zVm8wODhKVzJ0VllIWE1y?=
 =?utf-8?B?RHp4eU02T294amNONklEVk9EWVE4d0d6eFdhVGg3L29ua1FHMHZxWXVCK05Q?=
 =?utf-8?B?b1pQWllreng4UTlmeTRTMlNVT2J3dmNVdXNzYVczbm5kL1U2NzdNQTQ1bUpH?=
 =?utf-8?B?MjJsejEzUldXTXE4YjZTL3VtRjdMMllVdHp4RzdzUk1XZHFDd1V4eUg2b3BT?=
 =?utf-8?B?TlBzZGE3VHhIRlYrWUlSQUNuMHVnSGE2dlBTeTlLWTRocWtpWTJ3SUFqbUI0?=
 =?utf-8?B?dkVHSGw0OHVYTGVFRXFabTc4ODNhOFBhYURzZGlQOFVCa1EvTmhsQXg3bFRL?=
 =?utf-8?B?VlEyT3M2Sm1laW50QVJZdHBSdjRTYmhXcG9USmRsTE9VV3EvYWpEcDgwVTY2?=
 =?utf-8?B?OU9ETXNXYjRkUVdRMkR0Wm1WYXZlYzBaTXV4M3RTSEhqdVpBRVFVNEpVZE5k?=
 =?utf-8?B?L1p2NTVTRzJsOVVmRjBMTC9TcGhEWUMxc25ramxWRVlWYnZzUjNUZjVLM2li?=
 =?utf-8?B?NkhJczVMTUhBd2dXR1NkSXU4U0dPWU5jZXVoMmZMY01oN2Rhdjg4WlpRcyto?=
 =?utf-8?B?cVMvVGtCU2oxZjNNNmxka3dCbjk4d0o1M0tXb1V1cWx4ZFc4Mzdac3dpM2Np?=
 =?utf-8?B?OXdObHllTXlMUWhscWxrVDJIZlpCdlRuT2kyM1paY3l2cmcwZWNxcGh1cnNZ?=
 =?utf-8?B?Y3pJaWpncFNVcUZzTGJKMG5Xdi9aN1kwdXQzZU5Eb09wQUxZRGVIZVVWMktB?=
 =?utf-8?B?K0ZySVIzdW91RjV4aGQ0N0lxNG9vbUhNZVlBQTZIK094dVpCclpraUUvVGxm?=
 =?utf-8?B?TnlkdlQvc3FwSnBGalhqOC9rWEJONytiQ3V0bEJSdVMzQmViNjBRQW9sS0J6?=
 =?utf-8?B?MUJUNU5xbHBMTVhNSWk2UHNMa2dvcUhTM1lpNVNXSllGLy9uT1dDdGl6cC9T?=
 =?utf-8?B?S21TK3NtbTBkUExsbi9aMXp1NWkrczBqY3UxUEovMDQrdkJDTmJodHpnY3JB?=
 =?utf-8?B?QmJJY3dBUlZ6aWRnVzlGSXY3U09zamM2emk1ckgrZmk1T1JlK25aaWVpdmF3?=
 =?utf-8?B?K0FEQllsL1h4alpDdEJhMnFHYjhqS0lYSlRJZlpYWCtLZXpyR2N2Q0xTdVlD?=
 =?utf-8?B?Y1h3VGpUS1AzUUd0RjRPbmY3bkVWYTFGL1lpRHcrMWVlL0ZuS0tzWkFMQzJG?=
 =?utf-8?B?dlM2aFNQN3V1d1MrR1lSUzJBLytLaW1nV3ZMcGlvV0xMdXRDNUQ5TW1UOThv?=
 =?utf-8?B?MmhwOGpPTzF5TWpsR0pocWE2aFJNWkovdUlRNHJDdWlYRmgwd2N1TjExTnBQ?=
 =?utf-8?Q?lOIJee8/GnMcZ42Bm4XYBWnvYxZZGl14FSWlKyf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW95dnZkYUFqWnFwV00zaGtpT3RqVTd3K0M2K1QweXAxaXRqVmh2NU5qRElS?=
 =?utf-8?B?Z3JsUUk5a0NCUW51OGl6cmF3RDAvUjdPRFRNeDdDeUJ4bkkxd08rNkpUMDFj?=
 =?utf-8?B?elQwLzQ2dDJOdzAwQjB5Szd4TEVISUFROG1BRHNKeWg5THdGQlpoRlNROVhW?=
 =?utf-8?B?dWJQY3NLZzV0d2xwcVRhZkxSR3FJUThnTjlPemlyYWNValZDSitiaHRMT1FD?=
 =?utf-8?B?U0NrSGt6eXFoSEF3YStWT0U2NlR2Z0JxeG4rOEl1Vm5MSEFjSUEzc1lRN3Ra?=
 =?utf-8?B?Mm1uY2tSMkRndU5KU3BCSXZrSyt1c0F5WUNhMjZoejdPcm03anFhWmF0cnk0?=
 =?utf-8?B?ZjJuMzBpSGJHSG8vcDhPQ2pKWEtGYkZ1OG1KMFBsM1l5MWlzditta25teFBI?=
 =?utf-8?B?OHpDYUY3cjhBOTE0SGw1VGEvWm9qcVlLK1RGR1dmTVUvSlU0cU1kT2UvQWdJ?=
 =?utf-8?B?R1p5MEZuUG15TDZQRDY0NEM2OEdOeGYya0dSdlpZVXNVM1dWVnUvaitSU25k?=
 =?utf-8?B?SmpBNzZxdWI0TFhxYTJ0TU51RGlUcFUyemYyb3h3MjR1N1ZQcU1zZlFGbHRa?=
 =?utf-8?B?cXRWOFZzR2lMbWtBcURCcVFGKy9YZ3B1UFVGRHFjK3RwbTBTeUQrL21KVWVj?=
 =?utf-8?B?SFZiV29LUklpME1tQWZ3UDRIaUJKSFAzU0FYNU9vSVdsa1ZNdUlCU0JETzQr?=
 =?utf-8?B?dERyMkNsaDN1R2RiWkM2NWRmcVZKdm03cm1MaEVJYmZwMXQ1Tm04SUZpOFJF?=
 =?utf-8?B?enpxeFRGMWdYSHNub2NxQWM2RzF6cy95bjU0YlNxTU1DYkxhVXkwa1laWWZp?=
 =?utf-8?B?MFRZdWVFbWJ0OXVTMUs5eXBpTEpCWC9jNU4xLzlGcGdkZFBDdTdiOHZwejJK?=
 =?utf-8?B?TVdlaUpTeElvUmhHb3JBUHAwd0g0Qm9PMGVabUJUV2d2VW9vVXlLbEpueVY5?=
 =?utf-8?B?ZHR0Z3ZXYjRyOEVML1dNdFRsNXlQR0FRV3FXRmJyOWJLUUk1TjlsUkJpQzdj?=
 =?utf-8?B?aXd0Qm1zb01zQmRkVStzSTJnSjQveVdxVWozNm9GcTkrME1PTE1Qd3ZDdlFQ?=
 =?utf-8?B?UmpmdUlKb3hXWXFSb1VYQ29VRWxrVFVjZFFvdFA2a3RQWkxQT05OUncrTXRS?=
 =?utf-8?B?UnJkVnhmbjl1MGp3NUYvNTVTS1ZwUEgrdFZPZk04Mk5Rd1c5dG5Gb0ZWZ2pS?=
 =?utf-8?B?akRMYUR5bEZWVjB4TGcyUCtnZTFQakJINlpXNWRYSCtLUkliSTBDMjFDbHhq?=
 =?utf-8?B?ajVZaXJNalFLZnJSYlhWdHVEd3FmM2RLRC9Za1dRQURqY0QwQmVnbThTY0hF?=
 =?utf-8?B?TGtLUmZZWk51WUphQzBYMk8zUTkzeEIwakUrYjVRRml1MU5pQkJqMHZoT2Z0?=
 =?utf-8?B?T2txMERWeGlxS0RTUkplWHFneTgvOTJEc21QTm52cnVERXY3M2p6azVieVkx?=
 =?utf-8?B?SzIyS0FiRVdMTERaeDc5bFpZdzl4dDdma2ZoaEphelQ0Rk0wRll3U3k2YzBQ?=
 =?utf-8?B?Mmd6U3VWZWsyZFdHWTBheU9xeGJ6R1BxdGhkS1A4ekFIaTlMaCt1Q3ZDS2kv?=
 =?utf-8?B?T2dVQUp2bXhWbnhGK2kwRW1FZmh3QVp5ZE9Kd1FQV0FZTnFBRFZiTTVXQ1Ri?=
 =?utf-8?B?WEVpWDZVNVZaVjZ2bjZ2bWdNWERRVVhGNUdvb2JKQzE0dFpVSnhUcWxXNzJw?=
 =?utf-8?B?OTZpQWFyVU40Z3BHWm9KMW5pcDdKTXZJUWRCeGo3WUg3dllnMm5HUFJ6RzVG?=
 =?utf-8?B?bExNU2VjZHY1VFV6TC84R0NaUHo4Y2ZjaFlMRjZxb090MFhNV1RCcU9IUUtD?=
 =?utf-8?B?di9JK0ttbWU1MzVsTGZIRXZhUHdIZ1M4c1NEa2xwSTN4R3g2Y05vWmdUNndQ?=
 =?utf-8?B?OVEvYnpMb1VDYTJFMGZ2SHU4Ni9lOE0vU3ZMQXYrT0FQU09xa3dRNDZiTk9W?=
 =?utf-8?B?dXJXcVRTZE9WbVZoazRWaVRHb2djV3A0bTVQNGJXSXdMazNuTUMxVEZzeGw0?=
 =?utf-8?B?d29xT0tuQ2cvOVZteE1hSWoxRWU5aythT3FiTzZ0QytDcitRTDdFR204TlQv?=
 =?utf-8?B?L3YyNk5iYml4VTQwdTNIL0RpZHhscmFZeWtmUjlDUVNOYUQ4dmhBN04vaGtI?=
 =?utf-8?Q?telTvbsTxYNRuUYLErSD3o63Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e87cbe-36a0-436e-4562-08dd02c218ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:31:22.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDy7RANPd2A728rzhZ/TM3LJ7LjAA61B1gDgMUw/vwPI46lbxnBb2i1D8G6kuLU39u7kzVqC8+2HtphYGUQdFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com

On 11/10/2024 10:04 PM, Qiuxu Zhuo wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> Split each vendor specific part into its own helper function.
> 
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

