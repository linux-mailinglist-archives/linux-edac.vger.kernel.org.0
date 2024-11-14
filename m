Return-Path: <linux-edac+bounces-2550-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2F9C7FEF
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 02:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EBEB2174A
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C461E3799;
	Thu, 14 Nov 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNfk5ZuX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D1225A8;
	Thu, 14 Nov 2024 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547392; cv=fail; b=j+BGphMHWMxa8ovIowdmWAppzmETHTSNrYPzraHugqIYH175iDST9FV27UDIsoRWqmwTaCQJzyirZT4AI2Kat4W0e+lIp4iEZ2hVudglOHR9vqzNwOGkDxom6vJyVxL10lztpuBilsfS0kyMynHoV8ShDbWEdiHfLtPZk/Ntfx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547392; c=relaxed/simple;
	bh=EuFjWp955DJTBKp7H5RwfN4I/DfUqvwA9x7P0mNs/U8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9jlgrgVfm8/j5Twd0Rx6x3MUHJ8fWPFHS2ucvH9htagKZyroUG2gOv2M6d35AaIbVoKfMRwbQAd6a2lBAsprLWcfxCNErR8jC1tuhZv1Hgkl/fQIUFvXMz4txnJzi7+eUMoLjISrTYVBLCUFxCWhJFaHA0a9c7+D0JoZFNXRf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNfk5ZuX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731547390; x=1763083390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EuFjWp955DJTBKp7H5RwfN4I/DfUqvwA9x7P0mNs/U8=;
  b=nNfk5ZuX3PKE03ZG6aJDYNWvmSLks4A0/q8KGjUy2mSLUv6B/spF823s
   qpdwNiTxwyKcSd+psBT1CEVvQjArXcra5OIkl8ZEKo/96qiG6Oqeh9wik
   fyUJSFFjbKiCY3+6rnNxcVtjffeulpyV7xMOiG2ML1yoxkJpCARJseWXh
   kcX1UvsujzgSi1W3gyVpUaeMa86I9K92xIlXj7smdtGiRqqgFWLBMrhg8
   USFv2JuP00p5/5Lxa90605jLjiYwCdcnLcYn8eVVlab7/7TJmhxxUFbee
   guE7EHU8JXCop7ZJ6HXjRhv9KLExrNhU/bcrso5qyRScz2Aeo/qkiJpH/
   w==;
X-CSE-ConnectionGUID: Mfx0MU15Q1SIaJai4t/f6g==
X-CSE-MsgGUID: NOmCEa8qQy6OCn7IJpST9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="48972976"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="48972976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:23:10 -0800
X-CSE-ConnectionGUID: NkukU6P2S1mx7qx0CRGsvA==
X-CSE-MsgGUID: Zxc7f92fQx2tHlgBI+4vrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="87930480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 17:23:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 17:23:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 17:23:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 17:23:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sllEy2A2XfqdbT9zScq7FvZDy3yRYfk3zxpcAPQmzUVsHot93gYohBAqnuefbhvJKcWwpz1nHQW0i+ff3/xZvNK1DXNgYIZTavbX5cS4JXfHvbqrvvScdzIlKBdIaSC/n9SHPz6iyCfoN0Yf1ccjXdnt6idLQmO901wDKeJxmcpK3j9+cCMHwLTyx25g9ibLuoDiLZwS9hH2EIclcu+rp9r2Anw2kiFFTdQ0o3dtUoI1qECeZRHyZvtCfSaHRP50EnyuUaj6DcePJ6i6x3DhoWDIm2nyqYWt9DOruhaW6udlwSoFpXYVJO1umpzd9/eeHLNgtGAP9j5odv0ManjwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuFjWp955DJTBKp7H5RwfN4I/DfUqvwA9x7P0mNs/U8=;
 b=v+cN1H5YhEhXESS/sxO9jvaAr46iXtJLYRs6Qg9EqXAf6WQznmmYHR3vO1xXQyfW2JBNwoNZn18B0cyoJ4YQDvYjJzTLkAgV4UL8NplKV5rS+a3HteIBWtq1VbdDcMXEmse2Cdm+hQBESmLg5hDCCjS1g4/M2gpHKP4BIUNv3JhnJwN8Y96ERvwTlQdfU/dRb7xCeB6tEgzkwa0dAci1FjaiIvm/W+ZHHWcwgv8NeJWwcSyfWOzymx/4s5C3De2PQzWTRbC+jF0oGdhctXkKFdspNLhnxqWS6i9TcUrfSz4/PuUmPJ3NKeI4cB/EslfmCCLbU6agHiGqxEItw2+jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 01:23:00 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:23:00 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Thread-Topic: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Thread-Index: AQHbNAO1OgjxQDLqXUuhfof9VGSAjrKzyz2AgAFsUwCAAC3oAIAAmVRw
Date: Thu, 14 Nov 2024 01:23:00 +0000
Message-ID: <CY8PR11MB7134D1E28B28D62059E7F58F895B2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-7-qiuxu.zhuo@intel.com>
 <20241112154335.GD3017802@yaz-khff2.amd.com>
 <CY8PR11MB7134D5578EB260FEB1216353895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20241113161152.GEZzTPyLukGX8ALGc5@fat_crate.local>
In-Reply-To: <20241113161152.GEZzTPyLukGX8ALGc5@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB4735:EE_
x-ms-office365-filtering-correlation-id: d2121548-9704-4601-98b0-08dd044ae102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVZVdHZpdkRKOUVkWHZSRVhjRmlOSDl2c01aSFM1ejRaWVRqUkFmOHFNYlVK?=
 =?utf-8?B?bm9Cb2VtUDRwcHR2VGxuSmx3aWZUc3lwY3ExOUdiMERjaEEyb2pQc2hkazRT?=
 =?utf-8?B?dTlyK1k3ZmRHckNiaS8yeUFGaUVhL2F4dkJrcG1KMDZZekQxOW9BRzdpVXRF?=
 =?utf-8?B?Q1puS0dONEMyL2dwRDhOc3BKSS8ya0lQcWdOUnFvbkcrVWdJaGFRZTVhamhH?=
 =?utf-8?B?eFVqVHlUbWxaclY5VFVDdFJjZGxISnlSSmkwUFBxZHh3QU0rcE5ROXpTM21L?=
 =?utf-8?B?WXZKeDd3SnZ1ZmhRTHA4cHpFVXJBTW8wY0JIQkdPSE1hU2FsdnJ5VmFoWjNY?=
 =?utf-8?B?RlR0N1NMZ0o0N3cwdEd2SWFKL2VzZlVscXRZZEZCNCtGQm96cXBMQm41RXlU?=
 =?utf-8?B?RGh2VTJmMDNzSVRrZVlCVXlMeG5yWTBURHdIbGtZQmh2Q2V5czIzU05wMEhM?=
 =?utf-8?B?Z1h3ZWoxT0ZuMStiUi92WHhEMm5jNUVUYmhBaHExVmZVYjlNSW1IOGJheENw?=
 =?utf-8?B?dG96aDU1S25WVWhST05FT1RsbnNSc0Q0Uk5paHArWHE3MlBNeE9HS0NXUStZ?=
 =?utf-8?B?Y3dueFhoUng0Z1Exa0EwSmNGWG9SSEpVS0JNU29tblRKRHZyWEdBTzR2MWxN?=
 =?utf-8?B?UlJnZEk2UmljQ1F2bDl4NzlqRktPcnlnTTVFaEdGS3R0dTBYU2lkV2ZEQWdP?=
 =?utf-8?B?cURLcTY5T3R6cEFyV0owbkh3Vm93Z0FTeHp0NEtRTWRqOWNRT2dqbTZ5c3FU?=
 =?utf-8?B?dGhpeU9ld0hKdmo2M3JPdnFEYlVCTUFVenhQay9LOFhrTFdLRTdGSVVGM1JF?=
 =?utf-8?B?Nkgvd0xUbzJpU3RES2JndTJaOFVveWZ3ZFUxOGZRdVhyRUM2ZjdhVWU5UW1t?=
 =?utf-8?B?TnJHTjg5TDBsQUlYYnYzQ1Vya2wzMGRoa3hpUitieTZ6dmNBNFNmMGdZZHpQ?=
 =?utf-8?B?QVh3WnR6ZWNCNmxGZGlEMk95d0pQVkp0ZzB0S29tVmQ2ek5CamExWDV0Z1do?=
 =?utf-8?B?Z0pZdWhrY3paWUdoQTQrTzh0aWNWTExKVEwzOEhaTmZTUFhXTkxJRVdyc2cw?=
 =?utf-8?B?NHZQR2VLVUdNSXlqK1dUVEd4M010TEVMVXhIa01WUWJVSWlyajl2MlYySWJO?=
 =?utf-8?B?cHFHaCt5ZHoxclcza25pNzgxcVNLT3pvWE1DTklBVXhTazF4MzlJOFhCSGJD?=
 =?utf-8?B?bGRydVdoc3ZuN1ZkbjhvYnVJTmpUdXY1d1YrbWVERVBxSE9FcHA1YWg5MXYz?=
 =?utf-8?B?L3NWWU5XQit3MGFXSm1CVEZjRXN6ZW9DWk5pVUVZdGhSVTdmdEs1cit1aGpT?=
 =?utf-8?B?MVRBbk9PU2RkSE5pOXRFRUYrQmlLV0pTRGVQNlh1Y3Z6aXVhanFlZ0x3eWRL?=
 =?utf-8?B?OFo1a21hRCtiM1l0RzN2U3pidGlxNStGWThvNWRLZTIwcXpIc3dQQklocnBD?=
 =?utf-8?B?N2hyNDR3b0RHcGFRVytwbmo0d2l3RnRveStJLzllQkFOWXUwLzhwMzdzcEYy?=
 =?utf-8?B?ZXZWQlYxekNVTDFybzFtUmFtRlpoRkVRZVdJK04yYXloSEZ3SXdPSzVhRU1P?=
 =?utf-8?B?R3VWTUxkdlg4UU9ZYUpveXg3cWlJR0tvMU9kZmlsWVVCZFNWc0c5QkpsVXIy?=
 =?utf-8?B?cHNOY3ZvZzVqTEwxV2tVM1p5Z1N6OWZZMHcrMU1ybkx1Y0hyanV5QnhqSkRI?=
 =?utf-8?B?ZlcwbUhvTEp4UFc5SjRicThKYjdQKzJYWklROHZOVzI3V01UaFZpVlh6akUr?=
 =?utf-8?B?SUdrclNobVdkZUFBTE43Q3hXMnFvVDlzSm9yblUzd2RrYldoN2ExcithT0J2?=
 =?utf-8?Q?DNRnIrjlQGWzSmGESLE2tYEgobBI1Xg+xEcDI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBlVm5UUWhNcVlNWk1wL3oxSmQzUFl4SzR4dUNBVWlaaDhjbzViMWE3MDh2?=
 =?utf-8?B?V0srT29GcnBoUERYVFNuTkd3a3hLVmRyS0JaN1NvaXpKWmhzbDFncGphTlV1?=
 =?utf-8?B?RkNxRG5MK2QwWEZ5UXZ3TGlvU2huUVhhQWR0eFpyckRiNnIvSXo4QWkrd2hI?=
 =?utf-8?B?QWR5M2Jwb2JLT0U3cnJIR1lxS3hnNXpjSXA4azhTQUtRN0hXNXA2a3puU1RC?=
 =?utf-8?B?RjVlcDZXN3JmTTlnbnNYRDUzOWh0Tk9LQmViVzhHZlNjbkl3OUVYNmNwOTZG?=
 =?utf-8?B?N081Z0ZtTDJjejVTU3FvWVdwOEhBQnN4NnhKNmFKUzF6RTBIb1d2b0dBMzFy?=
 =?utf-8?B?VCt4WEJsaGxETHdWcXYxTnI0NVJpWGtZdkcwb0luV0dQMGVEMzFjNUl5cmY3?=
 =?utf-8?B?ME5nL2xhaDhUbWRWT2RRYUJBaXgxRWFJQlFMZGJyZ2dZcmlNNlkyV01rdHFy?=
 =?utf-8?B?YkkzU0cxaG1FaDdTaDFYblRtQ0xPRkh6SEw1NnlCelZjK0Q0djNHT2tVSW9s?=
 =?utf-8?B?elllVGtRYnh0YW9PZndmd1pBQk9neWpJaXpRYm00UEF2NnR1azk5YUNEazFU?=
 =?utf-8?B?M0lPa0czYkZVbEhEbk1leUlMNkxXaURWMHU3OUYyL0xsOHZ0T0xGeGNaQjdh?=
 =?utf-8?B?MHpPenFDMTRRdzZVRVJiRllzdnp1Wk1CdlZNSFRhQnBoZ1ZRb3B5S1BOUC9L?=
 =?utf-8?B?VmduMms0YnRqTjdFM0NiL01MVDd3WkZKQ091N1BoVkg1NlhuR3V1dWMxSENv?=
 =?utf-8?B?S3EzWUJSYzVRNXJlZ1c4OHZtVzA0WWIwSVhxU2FFcXlSc1JlNnNhUUwvcVFX?=
 =?utf-8?B?OG1QVkxlU2tmRUVXZFJEM1g1Z2JnSjRubjhvL2p2NjZ6VmxwWHJwWW80MGsz?=
 =?utf-8?B?OFl0N05LU3ZBRXJIMi9CWThlMXFaQ0RCVkloeWt1YUVncVBvdm55eUJ3dTIx?=
 =?utf-8?B?d2VINFVQaUZCdFB1ZXFvMitkUFJPTE0xWlMrTjVkcTYyeTFiU3dSeG1qVmVh?=
 =?utf-8?B?Z0w3aHFUMlFXaXJ4Skc3eWRLOHV3QlFROVA5Z1MzVG1mRkd0ZjMrRkluUVg4?=
 =?utf-8?B?QmpxMUlJRUNkU3N5QzlWZ0FBR1dwK3hCQ3Vmb2ZHc3pDV2JDUXM0NXozZnNp?=
 =?utf-8?B?RGFqZnIrcEczdm5rbU9pcVdBeHk2K2VYYVcxVUxXUnpMT21IeTJDMmxBQXB5?=
 =?utf-8?B?N3dDNW5JbThYaVV0cGV1anpzWk1QVDQxOENaZUpUb3V6aldmZnRZM0ZxMFM5?=
 =?utf-8?B?aDZJVE5WUDBKbUlrUUh2d1dMdVAwc0hwRjZwU21UVEMvUmpCTExqTmx2cTZJ?=
 =?utf-8?B?d1NXVVFUMDFtTzByamo4enhsUEJlcWpNVzlxcHdvUUFIdG5QbTZQZWZQRFND?=
 =?utf-8?B?bnovYk5lZEczQitSU0QyQkhaYU9TWHlOazFBaHpja29xb1BIZUZ2citoZ1Rv?=
 =?utf-8?B?aE5IWWhhRlcxNjB2MFE4bVl2NkxUWUwvWnVIamg4WFhaTG1lZzBseHpRSGM4?=
 =?utf-8?B?VWFMbm8wbGdqWXoxTXdhYmZIQTdNSUFZSDhLSHBDTjJiR3ZqYXhuUFZsZk1S?=
 =?utf-8?B?eXhSUkJRZkF0ZEJSQnRlVzZpVXR4cmhaNU9jRkNSL0lHSmFJeHBCaDY3dWZx?=
 =?utf-8?B?N3hjMlVzMnBwb3VsbnNIZU1sSnl4VVkrTGtyV1NQWVBVUzFxaDBhR2xlT29m?=
 =?utf-8?B?aVBaS01uZys3QU9aMU54VllkM3pkQXgwSnkzSWt3cHozU2ZnQWhpTUFmZ3Rv?=
 =?utf-8?B?dDBvSjlZS3VZdnBXNVh6cEwxOGxxdUdYeXc2OVdXNDN1SmdweklldklBT0lT?=
 =?utf-8?B?ZG41L1RwQnM4UlJBQmVkM2l2Y0swaEVFQXJnNy9GSTgrdXBjR3NWczZrMVov?=
 =?utf-8?B?aVIxUlFGL2l2N3AvaEp1Z3g3WWlLR1g3UUNjNEJFSllzRlRiMEEycU41TTBn?=
 =?utf-8?B?QkNqSDVOSFdwNEdWaXEwdGtPWWp6T3N5a3JTOHd2SU52K1dHck9IN0s0WVNS?=
 =?utf-8?B?THRlR0U2SkNyMlFuRVNLazN6M0xkZTUzN1FTc0JSMkVGaFR6TVllZTBNd2tP?=
 =?utf-8?B?TVpxcnZmOFFUcVRPR2NNeW1yYWJoRXpIMUgvTkV2c0lQODBlMXk4R0pFT2M4?=
 =?utf-8?Q?MnidWjITDzuWzPAbH1Te+p6Mk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2121548-9704-4601-98b0-08dd044ae102
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:23:00.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dko7FBISQAFa7u4icppKTRDXgA3ToDLKUEIhokZ/sqwoYtjM28BnzjRKDaI9VQsmjYCu8HtByCZsmU91Kf1N9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com

SGkgQm9yaXMsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFsu
Li5dDQo+IA0KPiBDYW4geW91IGRyb3AgdGhpcyBtaWNyby1jaGFuZ2UgcGVyIHBhdGNoPyBKdXN0
IGRvIGEgc2luZ2xlIHBhdGNoIGhlcmUgd2hpY2gNCj4gZml4ZXMgdXAgZXZlcnl0aGluZyBtZW50
aW9uZWQgZHVyaW5nIHJldmlldyBpbiB0aGF0IGFyZWEgYW5kIGJlIGRvbmUgd2l0aCBpdC4NCg0K
T0suIEknbGwgZHJvcCB0aGlzIG9uZSBhbmQgcmVwbGFjZSBpdCB3aXRoIFlhemVuJ3Mgc3VnZ2Vz
dGlvbiBpbiBuZXh0IHZlcnNpb24uDQoNCi1RaXV4dQ0K

