Return-Path: <linux-edac+bounces-2501-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD499C4CA4
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 03:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB1AB26031
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD619E970;
	Tue, 12 Nov 2024 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAGum5Ke"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F1433BE;
	Tue, 12 Nov 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378720; cv=fail; b=C038rmUPLh1Ihw77oGZJKJ5wQSm1YxCxEMjfawELTDr+R02FTqQHLg4MziqQU7zhFgvpHUeUmGMkxnUYZvAgFe/TkvahqB0I0gtsXD/pL55dvUdvKsY7a89Un7+r5wTf1AtpIINq9J1t3D7OlA7/KM7YXfU3dujQHJmyTTEqtqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378720; c=relaxed/simple;
	bh=8SPLFGzGm3r1op+1r+JphRH+ixVcI33dUuGrAZlsXoQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmQph1j+XvDvrGktsccq7ZmKXNgUpgUdPrrodQDRqSOsJEbuICrtub1OiZqp00F7yr3YgFMzeik6FIVRZ8QLGwJnSR171rDnyUOUslFAQE3uJTtEmJNc7vBTTX1zBdfecYFQqUQ2GE6Rc2DRk7fvXDQb2hZd+IE8NcKrrQgk724=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAGum5Ke; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731378717; x=1762914717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8SPLFGzGm3r1op+1r+JphRH+ixVcI33dUuGrAZlsXoQ=;
  b=hAGum5KeT24+Rq8KdwPjbuYhghpHvJV9wKVfE0Weq/BeCbx6HhlC/xKD
   3M4jcmu+N3gCZfs7BOns0bitQL4MI9nV44VH3HWvgnRg+TTkIUOJWytHZ
   jBBfxqpdN92uKfNrnyEIx8wZphw/aRIoA45pe4SzjpkeXEwGV+ImogxEM
   2BUsqp4Dz+hZUrz+ais3JJX6o4wzYBC6b45IzaJfuYmU1pB5UWupjXT27
   L00i1cUuKcRqB6SvKF+efYJT4K+6ErJTeoHm8FwzaiY6RGIGNHvnpQ87Y
   RaA4XfAIlo+fEk1jFo2eZy6JKc5xwIAoPzLiwYFVwfpcRvLQuwT6B2tGN
   A==;
X-CSE-ConnectionGUID: hCKZDcBJSPq/UJXCzf8EYA==
X-CSE-MsgGUID: W2BI8MHcQnKNMvAachaLUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30598888"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="30598888"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:31:56 -0800
X-CSE-ConnectionGUID: 8yZDFJ+9RxmzqHvESKY6HQ==
X-CSE-MsgGUID: p7xGxDl1SyOvADyZl7npVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="92150720"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 18:31:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 18:31:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 18:31:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:31:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCDiBHMZKe1YlZsb4gg4P6PnXsuttXkQ3nahvVUOuc8mHYGilACB2XYGry2BzDmskSHPeDE9PAnU2esKo8y7PyA9o4o7vVP4tGWpq4cnBkBYdFCLiRea+MBNX3Lf8ZLoms77iZO/WWh7I7hUoBmkaE/E4EoJomPeqd1xEZOT2p+wJW+kim+aZprr79/G31iRc05Rxi+8N307RdtMMsgCm4nd0LShYGHznSwJPwgPIWwBim4UQmFpMNiXTnVVZMe+2tghlO5CgWA0ofka3EtzGBW/LF7jBr+NgWvs7IrWqd+HvZ1NMNHcAiyTHLGTNVMp/JwGL55De3zJj2NcKTsgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nD4zX9ylNFo2DmHH5QKqQRxedOqMYOnL+7d6BymTI8=;
 b=bM/mvwVp6P5KJZpETdbEbtO/2oE6xdg+1G7jHqmW4nN+HA/VV2bUoFT9QO3GgxX2/LOqfIFmrWKQuS7LthMWogYuUrrGjFJmVIPrOHM+bsANUPicwPjL8PrUeUNVloIc9cXhx2yMI5M89F2fEhHFesh6tAomvbWUSwPUFbIFTHslfuqYYa0qGli44c92a5O1V47DbQg8TuRhSk4fcEzXsn7l+M2I1BiLt9/O11OuFzeWHl7pXiCsmSnltd4JIxr5Zgm1QzEkBKOhjPc1bZRQE2Cx2PpgwpmrNNG2a/oG6mN6a5gXWcHAuqcqfNcyOv1qq+0qT/rARRZq9cKc784ctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:31:54 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Tue, 12 Nov 2024
 02:31:54 +0000
Message-ID: <0c592f21-11ab-4318-b8b8-28c5295f89c7@intel.com>
Date: Mon, 11 Nov 2024 18:31:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <tony.luck@intel.com>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <yazen.ghannam@amd.com>, <nik.borisov@suse.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-6-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241111060428.44258-6-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3918db-789f-4acc-7d00-08dd02c22c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUhxYmFyK0ZzWXVjam9PcElYbjY3Si8yN2YwdFJrei9rb2dNekpTbXdyZzFs?=
 =?utf-8?B?VktRcmQ5MGJOVi9mM0ljeVRjQWRrSlVNU3hWVmZrS2hhcWFtMzg1YVl5amx6?=
 =?utf-8?B?SVBuYTZPK2pJYWtnODBXbUx5ZEpvTXhHNjFiY1pxRFQyOTM5YklxbG5XTzBq?=
 =?utf-8?B?dXhwcXQzZHdxc0tUNU9NVUsvaDROUHJiYm93SGFSVkRBYy9WQkNpQkF5Q2tq?=
 =?utf-8?B?cEh5cStBOTNEeFNOeEJTVmZvNVhFZ1Q4Q1pxVnkvVmhtSkkyazFtdCtOTVR1?=
 =?utf-8?B?MUZ3aitDRlEwdXRyZkkxRWtNeTlBdER1T3JobUl3aFlRdkRYV3hKeDZiYitp?=
 =?utf-8?B?UlE2My9hTGZzZ3JQMlI2bUV3SjNVWTB4TWlVRXhxUlNCeDVELzZ2T0ZnYllV?=
 =?utf-8?B?OWQyR3Z5K2YrSTlLdDRBVE9kTjZPZnZDaDFFMXZpNHg4dGw4bS9lZ2V1K0lT?=
 =?utf-8?B?ckJ6ZHFMTWtEV1JkMTNmUDgvZzBNcDNjMVk2WjYxTFFFa2hLVitIQ2FWVHlX?=
 =?utf-8?B?dkhlTmovVkY4Yk5SYU5XSGZUSlprSkh2d1NzRW9pamNuQU1MSkhZM0tkY21E?=
 =?utf-8?B?OFdrbFI3bm9hcG5laXVJS2FDdU91NG9yTWNKaUMzS1RaNnl3empLcXJjYzhY?=
 =?utf-8?B?N1JjWWtPWjlFR0ZTNU5JR01vRjhrZ3lua2RlZmtnQ08rQ2lmSkRLQWY1TlZ6?=
 =?utf-8?B?SzV1eVlwVjBJOXJPNTdQY1pMenRKVThmTU12MVJxMjYxOFp2cEZ0bzhpOHIv?=
 =?utf-8?B?V0dOWXVJZ2pRRE1UMHkyc08zR0tsNWZnaDZITkl5UnFrbGhvbGFkcVN4SFRt?=
 =?utf-8?B?Zkp4VnlqVXI1QU9EY1ZCUXVqTUpmTGlCb0hIcVJsczE0YmVPTVcwMHBVcmRO?=
 =?utf-8?B?aW9Pdks3cDJ3WDM3d0JMa1psYklJTXhJTHNBOFJMbW9hQ1JqT0dZWWNvYzdP?=
 =?utf-8?B?WVY5Vnl6T3NBS25xRnB6U1ZERmJHUHVRRllWK3lzK2Z2L3cxd2RSU0dXOGs3?=
 =?utf-8?B?TmJzRVJQbW5pSWo5MVRZUVhKQjJUbnVxSGltTVdON1A4c1NLeUZtL1lHUXJi?=
 =?utf-8?B?RjN3eFBSdUE1SnJRR3RqSzR0b0MwNXgvTzBoZXpBK1pLT1V3QXVDS2t0bFBa?=
 =?utf-8?B?eFJrRHVnSWg2bjhpQmVCUnZxVzFSK3dORUN0VW9SalA5b05ncDBlbnUwOFkw?=
 =?utf-8?B?eWlldmRBZW9wcU84Z0RBZG9PQlJpWDRrK2RCU1ovZGtpeFRhL1drUE5DQmVG?=
 =?utf-8?B?VlZWNkFXUFVPbW5pbktibG1kTzdoSmU1WXkyUVY3aVNzUnVJL3hhUloweWZZ?=
 =?utf-8?B?SFEzRDVocjVDTGNpSExraGdlLzlUZGRSNllkbXlxQWpFZDN1NVpPNW82a1Zv?=
 =?utf-8?B?OTQ0Z0gyZm93NHlaYzFOejFIb0h6Mm1aUGVXYlVtNEN4c1llSlZ2TjJPZDJp?=
 =?utf-8?B?RDVBc3RNYTJ5S3I3QlVBd2lDcmpSWEVSalNCdVJaL2p0RHdjMld1M0tabjN6?=
 =?utf-8?B?eGhoM1FsV0lWbERLQU0vTm9zeTU5S2d2cFRkVGgzVmRTQ0tqSysyNWtYUkFj?=
 =?utf-8?B?VTdtYkhXVTZPeVNsSVMydTFuUWQ2UXhjUnEyN1FydzF3OHBWZWM1U0g3RlVB?=
 =?utf-8?B?TCs1dURNMkNtRFRyVTY1UE9iTE03bHp2ZVdDNk8vUklIaGpiUncvRFlzOWlC?=
 =?utf-8?B?cWp1N1lDSjNMVWFBRUFOdzhYM25KMDFOUGR6bVlGR3h1NnJJdVIwbEhnME0v?=
 =?utf-8?Q?oP1i98dK01DT2c4GyJY+z4eSKDmZzCeR4nNy934?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJCSjFWYmEyZEpHQnN2dFpsSWpSRmhRbnVodEVpV25Edkw4MHZWdGZmRWk5?=
 =?utf-8?B?cmVRdmVrNTRyVE5ncTR1b01pT2NSS3FHQ1dnWDdEZk9XdmJEVHN0aEFCcXg3?=
 =?utf-8?B?Qlhld0JZc21IYTJyUGNVMUlTWVBiTzdyb0hTcDV6bVNSK0lkUUFnYWRnMzJ0?=
 =?utf-8?B?dGJlQ3RVOTRlTTlTY25JRWoxeG9nNHBKMUxVNVpwYW44Z0ovalpPNWk5RUxi?=
 =?utf-8?B?RmdKMXJBMHdXS1lpb0ZmRHoycmN2ZVhhc0VPVU9MVDF6N1dHMi9RZ1lLMFVT?=
 =?utf-8?B?VG91VjRvak1BbTVRdE5OTDhwQ1dwM1AzRi9uZEZZcERmNVh6RDlPZ0grMkVT?=
 =?utf-8?B?VVh4SW45NDRXUUl0anp2cHBZSWJHaHJhcDg0VDJFYjNyRmVqTnBHZFl6Ty9s?=
 =?utf-8?B?SGU1NnlCaUFHODgyZTZ5M1JXRU5pdE5rTjJ5OW9GOHZTZ29iU2V5QU9uM3BX?=
 =?utf-8?B?cjVxOUwzMDlneFlFNHVENUZTa2ZrZTgwVmlIZVJlR01pVVpnQi9rZWF6UFdU?=
 =?utf-8?B?aTdFcCtZYWdveTFDcENPNFJNZlNCdGF2NENmTURMV29oYTV2eEk2ejgwejVU?=
 =?utf-8?B?UVJ0MUtUeE54aUtvVDhjb1FQT21HSW5OZ1l4NUZwRGoxZlRRc211THo5Mmpz?=
 =?utf-8?B?Q3VOTm5ta2VheFRvaTBEYXhwR21vNm1SLzZLdXc4cTRLYjlzVzJleGRLRkRN?=
 =?utf-8?B?aTZmWFRYRm9zOEE4UjJSUzNtcjU2NlU3WFl0UEZPVkdpbHhDOHdGK01tT3Zw?=
 =?utf-8?B?VDNKYXk3MFFya3FrYlpYL2xNcGlQYnBYVUFLM3RzQnRrdGZtWTFEMXFIRVBv?=
 =?utf-8?B?OE8raGpFWFhDSUdtdWlzSnI2SEF6d253NmpDbWtSQStoMmFlTXJQTUdGYllG?=
 =?utf-8?B?eGpOTGROcWovRG0ramZIYkl5UjdwVUZmRnBpVGxYOGU0RnBuZ0NFdjVjbGRB?=
 =?utf-8?B?RDZpbVhBdWRlb3d3V1Z3OFFrRngrbXZFTnBkRjJSNjc2cmxlbUY1RjR3d3dz?=
 =?utf-8?B?a1ZtK1RRSU1VenByR3VETXdtTTMxd3RJWW1KQlphOFYvaU5Cam5vNU4rVE16?=
 =?utf-8?B?Q2UxR1hycjNtVWN3UDdoY280QTdKakpKb0NYUXE1Q3FFSGo3MW9HL21OYk9h?=
 =?utf-8?B?d2d3b0dBT0lHZ05aTWpCV2thNnBOeTM2amkwSGk1cG5QbHdZZW1zdWYyRU9W?=
 =?utf-8?B?NXRLY3gvQ2grbEFIRFFSc0FSSkVqeEVtSnBWUEtJdzhkWnZITGxBVUVnSVBv?=
 =?utf-8?B?MEswVWlESVcxMW5nMmdsWTltRU52NkhXZG9ObnYxMllpaHBJV0tLemJtMlFW?=
 =?utf-8?B?U3F2T3dKU0dtNmUwb2NMZXNSRy8xdTZLRHM5NFpXbjU2NzhxM0VxU0pPYjJH?=
 =?utf-8?B?OTlVTVdIeGNjUnFKdTliVjdWQ1U4ajFkN0d5UlZ0UG56bURkSGNxdmpUKzdT?=
 =?utf-8?B?aUtmTlFNUWc4U2RNRWkwR2ZKNFFlQWk0RE9zdk9paTI4SXgzVmxpait5MFhN?=
 =?utf-8?B?Vm45bzdhODN0T1RSSGlwNjFRK3p2MnRBVVNNVlA2UEdkS3FyNi90ZWpHWUhn?=
 =?utf-8?B?a2xjRGpSZmxzUHNhUUx4UHIwK2dXYWYwRFFNeno2MnFVNDlPRHFpUXBna1Mw?=
 =?utf-8?B?SDd6bU9LR1dXY1ZsZHVyUTVpeFNPa0RmamtTbi9hUUxtS2lkMkhVUjFFSUxK?=
 =?utf-8?B?OXdXTFBNSmg5M0NDQVdBTlpyTzNtL1l6RnQ1N3lISXN5cnVkUm15dkJGZFY2?=
 =?utf-8?B?b3E0RVdHdVFwcU53NXZMWDJ1N204UVJaN0I0dE54KzVkU0JPa1oyYnM2VVI1?=
 =?utf-8?B?aFM2RjZNWkx1Tnc5ZkhtWDNPN2tXYTl3ZEdVVEhOUUhZSjJUa0haN1N2dWlF?=
 =?utf-8?B?QXowMXluR0JHK0t5RTVlZWVpc3QyS1Bkei9WTTRWVm14TStIeTJVNkI2bTNG?=
 =?utf-8?B?bm1RdTdGb1JMamJHTlJFZlVsaUZtVS9lWTJsLzVYUFREMkxIYjBRV3JTLzFq?=
 =?utf-8?B?ZFQrbTNXSW5ZQVFKcjBEV1ZVaUlLYXdMTW8xeXdsaHg0SGlId2FMbTgrKzRv?=
 =?utf-8?B?bFdOWGFlLytTeCtsaVFRZitjaTllRkpCcEVna05JWFJtd294Si9CVVl4TVVP?=
 =?utf-8?Q?OMTjVV9DzgolLBVPvfVM3RDQM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3918db-789f-4acc-7d00-08dd02c22c2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:31:54.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AELFueCjqcYfL8v6ckxNR7vQNmMtPoyAHz02d9nuyLtbB2eZnfKOELbWWimG7BvPPcaCNJJf7D67fJYTBNdOpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com

On 11/10/2024 10:04 PM, Qiuxu Zhuo wrote:
> Convert family/model mixed checks to VFM-based checks to make
> the code more compact.
> 
> Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

