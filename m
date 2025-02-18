Return-Path: <linux-edac+bounces-3114-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8437A39136
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 04:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71343ADCAA
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 03:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999714F9D9;
	Tue, 18 Feb 2025 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsKeVyL4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CA18E1F;
	Tue, 18 Feb 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848614; cv=fail; b=DaC7JnZyDJ62IU+Mbb7oB12fXIOzy5v0F/srP6DAAVJEyXzpwQWo4ztx5laviVvzsy5xgRfwYra68j8J80mGZ/yByGsoJ/Piwx3O619tdQrk8io1UbWCw70EXcbsX8ZlY68UhtRebC+3JOl1ByYpXgjNzkL5Sr/gsRyDxbFGjmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848614; c=relaxed/simple;
	bh=E+xvre91U1sFQe4/D7Uq0zAvCGjKAzieqIuZrEnuyRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajnbGhILm4U/9388YlvRtk7mPp8rJWxhyPpgJu0y7KFNfL3VYY6qp+p56zmjkXHzUvkenZ0vjRRERtwHmZOLdnJK+k8fhRGvXOFncqGSgWchRBi39gMVG4iXa8Fr4+2znjpO+NkoftCMrFBF7d5chlQz71oCDTGMLz+B937eyFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsKeVyL4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739848612; x=1771384612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E+xvre91U1sFQe4/D7Uq0zAvCGjKAzieqIuZrEnuyRk=;
  b=hsKeVyL4LERKxI116v7YpgaaakbbwtAz5MSdT8FyPlIa2RpzAU+KCzyh
   H3aIXqAUhtIBtjpgGhsrM2MgRyZEyZ63uGZMlLEHzniMDqtkxa8OLs3av
   YRLikxFweODtwFhqPbkAZUmeSAmBlRhdPB7WbcG3MQwePME0Ga8qLLj/X
   +6bAkso+atfNVcAVJoFbY1eLfSvQo8YXOcNKAS6MavdRyr7W3bmSTaIQB
   N8R0Z1HbC0j5iBfxt52royIe4279ab7GoRSR8+1Ez/BAqhWvktT8UtWAU
   Eav6VE8a05iKTSF6s0nhNBNW5+1EgMEmdpHScX9qQvZbtBIsmuWXn9msZ
   A==;
X-CSE-ConnectionGUID: mZ4gcigxRD+TTXkhJDwN8w==
X-CSE-MsgGUID: 2mpr5A61Qf6hw6vhLC3DUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51176012"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="51176012"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:16:52 -0800
X-CSE-ConnectionGUID: zWhW2fb7TH+JAZUvnbOBlg==
X-CSE-MsgGUID: X0bg2cqFTbC6ILjNYygfNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137512465"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 19:16:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 19:16:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 19:16:51 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 19:16:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5XoMx1oXOpCXxjqfTadndeILyrdRHjTn/nmt18JKmurDj3TTK9KUBqUHFoQhiIeCACF/R7C7Y119K0XJB8qvaq865/ZmnWsnF8Ci7V1CsEpTQlyTHYPhECASByed7Of1qK+7WyHIkZpxh2oq0xJEeoL8BHy1f6UvFe04Lrw4rChxAvys3v7Dk3qOZ1RPo9FshRY/7TNir9uRM/K1Qf57bbTcUGx1q+BXaSWI/abCP6ilTR4qQMZafXJjB5zc6owceQ/3gYhHXE3TIjruzOD0A3f6tV2ZU5+SO9YF3Q8IRnKdAWNKNh0JaIRdpg4EXTvZBDVRyEJoy68V+53HhvZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+xvre91U1sFQe4/D7Uq0zAvCGjKAzieqIuZrEnuyRk=;
 b=FXqpMz/LORiM7uadC7oEN5J8Z6VSHUf2TNemUNnN9/Vfp0gdR4yQcA8YRvK8YyZB7p0Dr9NH77Zo3vlisWizuyxNHzbfrdftaY6LdeBNMHjvptfyjA7g3HJAV+Pv1AToXw7ImvK4Ctd2V0zca1ytUfrLGUWDLarbFKtHYVkJhwLmHS+5UohchBlZbzJMYYcZir8+LviYclOFVOB0+cbVWUOmij80E1/N0lmaCDK0jqd2N9SMKQdcbABYGCiInI+AiPZTpnkHe1LfkRCXT1Q63iMZrWgHWRK5833UgZf30WMn0C8aXgThuYun2+L5dYgQyxzfWXCjWVSUUPOqXahbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 03:16:49 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 03:16:49 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 07/16] x86/mce: Define BSP-only init
Thread-Topic: [PATCH v2 07/16] x86/mce: Define BSP-only init
Thread-Index: AQHbfjlT9nBBe5Yi8UGLWXfjZPPcjrNMZ98A
Date: Tue, 18 Feb 2025 03:16:49 +0000
Message-ID: <CY8PR11MB71348FE4A5684E941992B5CA89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB6728:EE_
x-ms-office365-filtering-correlation-id: c86ab72c-16e6-4d76-2ca0-08dd4fcaaee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUp0TC9VMHROaEFLZUVTQXpveGUyYkRPb2MycGlrclEyVkxtdzMvTktTN2pk?=
 =?utf-8?B?SFBBa0JSNVBhcGhCQmEzcGJiam1IRlNUMjRuS1gyRnl2algrbnNGNTdSeC85?=
 =?utf-8?B?ZzB1M2ZwNHJGcGNHSVRFZjdYenVZOFk0bm44eUVpOXNqY0NqcUVSa3B3aURm?=
 =?utf-8?B?L0NiNVN4VHdaTExhL01BRkFjZVpVYnhsa0hGcW1tWHdXVmIwUFR0UUpMVURX?=
 =?utf-8?B?YitlK1hTcnkvR1h2Y1RZVW5vK253QmRDMDhGV0c4N0ozMHpVRUdFUjNhaVdG?=
 =?utf-8?B?Z0s2bUMrU2pIVm5qR0cyQUdqVlNyRDkrdVFzdHlBdTNPSEdKUGUyZ1lHTWR5?=
 =?utf-8?B?ckNaTWRiSHhnNmN4ZVdMRGt2Mys4dG1hZ2JCZElCTHQ5U3BXU1F1alZpRGlv?=
 =?utf-8?B?VFRGcVJDNGVqd3pHdi80RUp0Zkd0N3VhN0d6ZkRLS3RzbXBjcHNkMFY5WEVR?=
 =?utf-8?B?T2g3d2taa0pSbzEzVUFNT2hzSXQ3VnhCbEtNT1c2U2d6RnRXcUJUbXQ1NEdC?=
 =?utf-8?B?cXlVWmhQb2FJblM5TE1KTnVKSnBiRnZsQUJ3TlZ1Q3h0VGxzakZHb3RCWHR4?=
 =?utf-8?B?VGsyRjFCd2xiN1I0Sk80TmJlS1FYd1hnVGpSQW5GRlBjNDBDWFpIdXpmU05q?=
 =?utf-8?B?cUJnYjg2RndNQTNPaGllU0o0eXEwODFqVzBwM2tFcHpnR1FUU1hQK0l2Zi9q?=
 =?utf-8?B?dnI4YmRnWTN1U2V4WkZuLzFMRk10S2JmWlJSaGRsNTdNaXkwTm9BeVBHUkIx?=
 =?utf-8?B?cVZ6NVcxNzlaZ1JOZjRzUjBzMjlncEdhZUg4dzB4eWg2RUtxckNFdWthbG9R?=
 =?utf-8?B?MDRLajltZmhZS0dRMENmR1B1VWFFaUs2Nlg4RnNiSUplUnpweW4vUFNvWS9t?=
 =?utf-8?B?eWs3ZjkxWnlkaTZCN2NlUGxpbjZJUVVuUWVaZ1ZWNmdYQW5nRWgxeW9IVE8r?=
 =?utf-8?B?dC8rUmgvTHM4TFdzaXROTFZoL0VqYUpTZ1B6aUZYb0hocEVpS1Q1VGpXWEk2?=
 =?utf-8?B?cklldnZjbnYrLy8rT2FoNTdnMzB3TWZDa1dNWWhSb3VwUXkwcVVJQVN6aFVH?=
 =?utf-8?B?ZWhUVFBlUHBvTGtreWw5TmZubUZSOTVncytlZStEWDVmSmNyUU5IdEs3aVVx?=
 =?utf-8?B?QWZIYlJqT1lQb3phZENEbjBZMk14blBKNUtNZmxFMHBOUkt6ejMrUGJnT0Vy?=
 =?utf-8?B?MVc2d3ZIc3pEcmVYQ2dHMGMrL09Cc2xqT202T2cyODUrWWg1UzNNOElPa1ZW?=
 =?utf-8?B?T1loOGcrY1h6RmhhZElMbVlGcGZ4VjNJeEw4U3huR1kza1lwSVhqZ05nRUFM?=
 =?utf-8?B?TXlIc0YwYWJkRHhjbUI5dDJkcElXazBTZWllN0t5WUNGWDV4ZkR2UjB5MUpK?=
 =?utf-8?B?MTlHb3Z2VmNPMjVtYXBrTlBNbjFIZDNsN3gyUHJGcm02SXlHN0dGL2tPVkFS?=
 =?utf-8?B?ZjBPVEx0eWVaQ2dDdXltUjlwSnBHNmUxMVZUT282eDVoWnVwVkJHZkZYQnNU?=
 =?utf-8?B?d1VBV3VFWExyQ2t0eGROZmdTZjlkNlRocXVxZkh3TmVON2NoOHdQSWVUK09T?=
 =?utf-8?B?OW54T1ZoekJZeXZ5YnRDd0pBL3pDRGx2UTZ3eDlka0pMS1QvZE82dzRIbDN6?=
 =?utf-8?B?dXIxK284eWgxdDZ5WjVnRlZsYTBqa3RHWlRVd29wZXo5cGwzbVp2OXI1dEJx?=
 =?utf-8?B?ZjErZ3g2aUJWd2RvdEYwWWsvSXFpUFdncUJQUWUrZm12dUNjUGVRN3p1RmQ0?=
 =?utf-8?B?blEwcGR1NnprUU9uN3lIMVVXQTRTZEsvMXF4R2hhdEVEdEtpVXJzNzRwQ2gw?=
 =?utf-8?B?WUxBcFNhNFZpcVZUd2EwZlo4TDRtUFRiOU9ILzAyL2hUVVpuSjVTWlViRGIy?=
 =?utf-8?B?T3NEWnFwVXdhRmluK0s3WFdqckhpYy9GTGZ4S1lFbzNrVE1jaVNiYXdyOGtr?=
 =?utf-8?Q?KG2VUFG5UtifM0g3MHg2E7taER6pAHmA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3hhYmdKeHpzZVNOR2lwN3hVek55QmZDNC9qVDdGM0RVbFM2TlpUVGU0QnFl?=
 =?utf-8?B?cUFJWE1XK2FvYVJFVG1Yd2tScmQwcjR5Sm1FQ2RpajFQN3p4K1pmN2F1cjlo?=
 =?utf-8?B?Z1pKNWVkSWVpYUk4SWVQTSs0UmwveU9DMHdiWmNndHZzV3BXMjcrZ2ZubmFm?=
 =?utf-8?B?Z3lvR3VheWxIRVJxamdZbVluZ05NZW1DTHlwZ09USG5XSjlqRFBLbERDdGJY?=
 =?utf-8?B?YW5lNVI5M1lUa0kzU3VnaWlQVnQ4ZjliYUlpQlpERHNRMjRMbDl0WWEwdW1D?=
 =?utf-8?B?eE54YTM4UkRiS3lyTFJKeW1tVlFQZGNFdW5VeVBDdklMZnFBOWNPSVVLeVp5?=
 =?utf-8?B?dnJPckRvamMyZis2QkdaTlM1MlVUNWcybHlmR0tFMlFxSzFZOW52VkdQZk96?=
 =?utf-8?B?QkxSU0kyYnpueXpZc3Y1RzU0L2VKZ0ZEbkhhaG1xbUwwV25CL215TEl0bldq?=
 =?utf-8?B?cHR3a3MydGh4VWpSNFdxNGVQSitrR0h3Q1h5ZElaUU91MXNVT3FBRnN0d1ow?=
 =?utf-8?B?UFB6YzBtVzN4aURYTzJINWhDMGxiWmJjSytRdmhMemVGN09xU2N5YnNtNkJK?=
 =?utf-8?B?TUI0WFV4dGg2SnZ4WTJ5NVFRZ0VmOXlTQnNOcGZyNmUxTWxEaE10TTNPTUNM?=
 =?utf-8?B?QmlPTFNSZHAxb21JQTY0SWZXbTFPT214MDkwT1U3OG82SE83b2Q4WmdzYks0?=
 =?utf-8?B?aEdoSFdZVXhoUUIzUnRUNnlKNEovVUd6UmRHbk5wWlV5ZXdVWXNkc3hwa3RB?=
 =?utf-8?B?MHcydG9PK3poTkhJTU45RitDdW1WQ2tMUDVMQXBLcHg4KzZLVWtVSm14N0tQ?=
 =?utf-8?B?Z3NlZGpyWlFGVFFMV0tRbXg4UDM2eFdtK2VPVmhIbzhhZkVGYklqUHBqMEhG?=
 =?utf-8?B?SmVmSmZ3YnlWK29rTktQaTdMRHllR0pydUpDUDBXNXMyVy9WdXpxUWVyV1Bs?=
 =?utf-8?B?Q3N4dlVreHlKZGFpTzd5VGNrd0didkRRdGlPS0dQS1pYSlhCUWsyMHVuczUr?=
 =?utf-8?B?dHFZVmh3R3laQk5tbk1CNVV5VUtCZEpPd2lmL2VtRUh6b1lwalBBN1RUSklm?=
 =?utf-8?B?eUtNUUFmTFhoZmhVOVd5Q1RvNTFKMmxhTWRxYzVRYU9ZcXpRcVQxQW9HbWkx?=
 =?utf-8?B?cEJuTjEzaUx5MFNIWjlYWlMrRStQZmlPdG5rekVnMUNBdEZUTGRuWHBhbmtr?=
 =?utf-8?B?RFhxY2Jua0RPSFY4dkd0Tnh0VEk1VVo4SEN5NVVOWjlnTGNZLy9iblJ1SUdN?=
 =?utf-8?B?M1pSWVZ3d3BjRWxCc2JYTDVqQjQyTUFvWWJqU01mZEh6eDMrU0VOV0tISTA2?=
 =?utf-8?B?eGtQcG9QYXBUa2N3bENnYzdNYU00ZzFnLzRIeDZ3SFg2cU1XcWNzWkJ2MnJP?=
 =?utf-8?B?cHg4dzhZbEFVS1A2MVZPUHNxdXFsbXZZaUpYVGxuODJNOTZPY0ZPaXd3c2pR?=
 =?utf-8?B?TUNET0hZWkRSS2hpdm1XeklRNkpJdGI0eDFJQy9wM0IyRStrZHY2ajBmbDQ4?=
 =?utf-8?B?NUdFYUpvWGxGS3psdHNidzY1enJLQ0lyTmpqdVVyQnoxV3pjZUxrMFd4U2la?=
 =?utf-8?B?VytXbUtkNXZUK3JUamxLdzFUQ05WN0lDVHp3M0d1MWVQV0thcWxZbm5JQjFs?=
 =?utf-8?B?V2R4NEFvbzM4ZUp4TCtyLzc4Qy9Bbm9zc0VMK05iVGwyRDlqazUwT2MrWVFZ?=
 =?utf-8?B?SVpUNDFENUZBR1pyalhIbUY0bDFJakxUN0VFYnJzMUtDZzhOVmpNVXZqMHVL?=
 =?utf-8?B?eDF6cExIWDlGeHlSNGdWVmJrcmpRWDVtaktTMktvVVJrV1A2TTNRQ3RBam5D?=
 =?utf-8?B?M1hneFQ0Mkp4VVFmNXNuZUhwT0lDTjlPZ2orcWNaUTd0R1hMVzhXTHJuVklJ?=
 =?utf-8?B?VEk4UVFmbk1sRTBObUNGL1FzNXBaWGt3LzFWNlZ1V0gwVWFEb0hsbFlVUTBl?=
 =?utf-8?B?U0NvUDkzWXdtZzRNQU9YSjdZOGd1dTV4c2ZkaWRhcVp4cW15NlpISEVUVVU4?=
 =?utf-8?B?bk9SR1l2b2ZSOWpmdjVFdlNqYUVwUXI1YWwveWpVeXZ6Y0k2dEhpS01aVUQ0?=
 =?utf-8?B?dTZ5Nnh2cERnV2h1SW9NWTNucjkzNm5aU2szYU13UGZpSk1sakhRYUxxbUQ2?=
 =?utf-8?Q?FlDdw/KkLLq1sDbUN1luH13c8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86ab72c-16e6-4d76-2ca0-08dd4fcaaee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 03:16:49.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyKxMzeLNqRxZqDK9/NUs7S5SPUtGIZn+Qb44nrV51fm+2CL2wfwhWb0cY1Uk/eTIFPleUg7sKgNEYYVBC9jpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFsuLi5dDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYw0KPiBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2FtZC5jIGluZGV4IDMwMmEzMTBkMDYzMC4uYTRlZjRmZjFhN2ZmIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYw0KPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYw0KPiBAQCAtNjU2LDkgKzY1Niw2IEBAIHZvaWQgbWNl
X2FtZF9mZWF0dXJlX2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPiAgCXUzMiBsb3cgPSAw
LCBoaWdoID0gMCwgYWRkcmVzcyA9IDA7DQo+ICAJaW50IG9mZnNldCA9IC0xOw0KPiANCj4gLQlt
Y2VfZmxhZ3Mub3ZlcmZsb3dfcmVjb3YgPQ0KPiBjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX09WRVJGTE9XX1JFQ09WKTsNCj4gLQltY2VfZmxhZ3Muc3VjY29yCSA9DQo+IGNwdV9mZWF0
dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfU1VDQ09SKTsNCj4gLQltY2VfZmxhZ3Muc21jYQkJID0N
Cj4gY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TTUNBKTsNCj4gIAltY2VfZmxhZ3Mu
YW1kX3RocmVzaG9sZAkgPSAxOw0KPiANCj4gWy4uLl0NCj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2NwdS9tY2UvY29yZS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0K
PiBbLi4uXQ0KPiArLyogQ2FsbGVkIG9ubHkgb24gdGhlIGJvb3QgQ1BVLiAqLw0KPiArdm9pZCBj
cHVfbWNhX2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpjKSB7DQo+ICsJdTY0IGNhcDsNCj4gKw0K
PiArCWlmICghbWNlX2F2YWlsYWJsZShjKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJbWNlX2Zs
YWdzLm92ZXJmbG93X3JlY292ID0NCj4gY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9P
VkVSRkxPV19SRUNPVik7DQo+ICsJbWNlX2ZsYWdzLnN1Y2NvcgkgPQ0KPiBjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX1NVQ0NPUik7DQo+ICsJbWNlX2ZsYWdzLnNtY2EJCSA9DQo+IGNw
dV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfU01DQSk7DQoNCjEuIEJlZm9yZSB0aGlzIHBh
dGNoIHNldCwgdGhlIGFib3ZlIGNvZGUgd2FzIGV4ZWN1dGVkIG9ubHkgaWYgdGhlIGZvbGxvd2lu
ZyANCiAgICBjb25kaXRpb24gd2FzIHRydWUuIERvIHdlIHN0aWxsIG5lZWQgdGhpcyBjaGVjaz8N
Cg0KICAgIGlmIChjLT54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EIHx8IGMtPng4Nl92ZW5k
b3IgPT0gWDg2X1ZFTkRPUl9IWUdPTikgDQogICAgew0KICAgICAgICAgIFRoZSBhYm92ZSBjb2Rl
Lg0KICAgICB9DQoNCjIuIENhbiAiIG1jZV9mbGFncy5hbWRfdGhyZXNob2xkICA9IDE7IiBhbHNv
IGJlIG1vdmVkIGhlcmU/DQoNCi1RaXV4dQ0K

