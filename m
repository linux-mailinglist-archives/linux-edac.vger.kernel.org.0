Return-Path: <linux-edac+bounces-2530-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3209C778C
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8582B23E12
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F6C38389;
	Wed, 13 Nov 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W45PFk+V"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D423A0;
	Wed, 13 Nov 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509310; cv=fail; b=ERRrFPOQNvLa4LAN5JPy0sO7PUUNNf4tH+IbxWOhMftcvf5kau5x8fyx/IhymkI4lfVEhNWIPcMKylLTD+HtZzvGloCOYsxKGWNAD2h9bEW+dwHCUsqBwc8Fp9B7e+hPqVbtnE1gwV3bmjaN42eCFD1VxkCVLNArouG/FoiSahw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509310; c=relaxed/simple;
	bh=AqNIH3ka9cKaGnTxW+VcrijsuOLAxYH0kDypKXHPaCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxhtsIJSvc5kQY4BUz3P1sl5SnJZtNi4WiCZznIWlOz6oWkP8u0QOL7+hwC1G1COCVhilGEVMFYSn/ZNl09TLJEx/etLOLdczHnc4+RTFKptJkQ5NLXy1ULt9JEN5dXw2oIaX4zyxrqr5z9NJNAsxFsAaX3R4RQEMi1OmObFx7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W45PFk+V; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731509309; x=1763045309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AqNIH3ka9cKaGnTxW+VcrijsuOLAxYH0kDypKXHPaCk=;
  b=W45PFk+VC1jLxnRqW2LIetwC8NU3r3yi+cO4PAVktNCiXMJ2C94CEZp1
   Zcjrn7FbU2E3OGAHt1cqNppoirsVIb6jvQMTMelFzbfQGXs+smrca07+Q
   qGEyTvVUOkSbCXF8whrK8USVeJOAjs+TUEskUH/BBa26xO3cvIU44jCvR
   lBP0Cpi0A271jm5lnMsNgXnWAekFMWchpMUOwLxRvyqABi/536Qw0LGnq
   NcVPOxd4J4Vx+YgRWER0UmqdWGGV54k4Z7LSCEJVBgwXVzFjvc+69IdSP
   h1VXKihT9wlfNfxz4tmor/TwWQNiYinkugb8THvSIAw/1X3q2s6ZOsmLs
   Q==;
X-CSE-ConnectionGUID: bJt2HxrPSgupv8ZfocLW6A==
X-CSE-MsgGUID: y/DFl+LTRVq3af+IT3+6pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42794959"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42794959"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:48:26 -0800
X-CSE-ConnectionGUID: W0TdmwduQmG2jFwg5QBO+w==
X-CSE-MsgGUID: C8nJiefrQgmKmLMmNDpZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="88315824"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 06:48:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 06:48:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 06:48:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 06:48:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1HZZ6LwZQYqIxQTtaa6pOFzZqJWrrqqDSnnnCeh66plfaNy477OpJGuJs4XGp0joOUfEFcqJ9XoqcNDHLCwYCchYHs3Gp1sRfL7+Tv+57SaZyh3wSngp8KsrX0NWzbhw2X828mYsHf0vMqiqf5cbNmuSRWtSrtipGxdvtHlW31niLseo+IhX7yjwypHpnBd6F3fu57C6MK1OdbljFVp6nkrDOPXsGBcVzVaHXM2G27prNlqS66XwpUpg1dvWlBG21IEvLV3SDxF4Xaqf36KspEpfkcDTpGJ/A4AW0j63YFQXRN781T8ta9JTbo8ZxKUI3//YBXD6GakrRPlWA09CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqNIH3ka9cKaGnTxW+VcrijsuOLAxYH0kDypKXHPaCk=;
 b=xhBn0AdcTPYafv7oiIemZs5uBOD7xv5m/YzHlJOkc9s2oVCHbgwSblUBwipYuMXAIAKL7QIKETp2fLyTIDIUlPaAqqDjobj4u0AFNXU+TqGr12UMivIlt/RAi6f+sUBGsYp7R7fsCyBCb1iFuxqEzDHQaZ2Ngnr2DpkTPHiFNug4O7A5hB8sqP32iZcgFg/zwm2BGQgcv+CD1txo0t1bPefkDcAnlnwWjxs0mxgaj37j96gwfD1UcH0dLtM8+7bkjwaHbX7YUjowdvmeZck5XVvEk3RqKc36zfvBBecVIdeN/5VAebrBytWKQ2c43Wx2OVz8/xDk/nRQlbg7nfoRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:48:23 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:48:23 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 8/8] x86/mce: Fix typos
Thread-Topic: [PATCH v4 8/8] x86/mce: Fix typos
Thread-Index: AQHbNAPFEd+OSdQ6ZkCzBYbpcY5i67Kzyd8AgAFvP7A=
Date: Wed, 13 Nov 2024 14:48:22 +0000
Message-ID: <CY8PR11MB7134D5AE729B583BF1BC7B41895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-9-qiuxu.zhuo@intel.com>
 <20241112153842.GC3017802@yaz-khff2.amd.com>
In-Reply-To: <20241112153842.GC3017802@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4572:EE_
x-ms-office365-filtering-correlation-id: 9d980b72-48f4-45ad-4787-08dd03f23905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UnplL3hMSFR4RWZEMGx5MVZIVDQrYjlUNmVKNFMrejRnKzlrbmFxWlRNeTVk?=
 =?utf-8?B?V004MWNHdkxnOUY0S0xpNFA4SGZYN2NrblQwZHlwVy9nUVRqMHBHQWJ5U01L?=
 =?utf-8?B?RjlWVENoSlIzUWR2anVaUmdHSERwTDdVOHJyWjErbHkrbXVvQkt2c0liOEZ0?=
 =?utf-8?B?b3pmMi95Zk1WMXZBQW1xd0d0QU1FN0hreW9obWpvdXpWNDdpd1QyMCtGL0Fz?=
 =?utf-8?B?RS9uQ2VNbk9WTWpuN2VlWjRJZGdsK1ovQWYxUUlCN1R5eGlyN1A4MmtETVJD?=
 =?utf-8?B?ZWZjcUhCYU1ub05MTFdlT29uKy9PUk9nVDhoeVMyK3poMDVWQXpERjlRR1Rm?=
 =?utf-8?B?eGwvTysvVmN3Wmh1aDlSdFNxU2NhbE1aSVdheWI2TnNNdGIvZ0pnUW1zU2tt?=
 =?utf-8?B?eVg5OGhKS3Z2akxDQ1FKRWJWRGp2MVpXZVp0VUptaCtla2ZvSGoxdklVaWIy?=
 =?utf-8?B?MmEvZ1lMMTh1U0R5WUpPRThOODNZOGhad3c3eXFLSDBCWkFoRUdtV3E5d2Rw?=
 =?utf-8?B?NTNxeFR2dGNjc0JCN0l0a01VbmlkZUxWMXNKaFNUSzFFZi9JdUJScUtKV3hr?=
 =?utf-8?B?MmFUYmdrNnNCcjRxdk0rVVJEcXlCdWtyQXJKb1k3SlU5K2I5Zm1FMEwzR3U0?=
 =?utf-8?B?SXBZNmNYaW5jKzRadStLS05ORGFXaExBWjhMZkMyZmdxT1dDd0k0SFVzVUJ0?=
 =?utf-8?B?REdyaEo4WTArMklDTysyZ0hLLzZJVzRTWTh3b0tDcm5kY0cwMEZWekJpV2tI?=
 =?utf-8?B?OVRnTmtoeVZ5YWJCVkNtOUFZcnQ4ZUlRNkJWM1R5RkdFQlAzVFBaUktQYUF1?=
 =?utf-8?B?eENORjRkeXlUK0kvNzlyVzVGSmd1OHpKNlpMUGdlTWNlWEpxUEJXbGNuR0VS?=
 =?utf-8?B?TVpqbHZEVmRxbm9Jc05TbVZWa1RrZWdCUVNsQTNoVjZtMlpuUWh2OGZXVHhy?=
 =?utf-8?B?cTdwRnJJdkZOOStsUlVCMzlpTnpYR3J3T0FIcnFKSWpDV3RFT2dtckRHTjRL?=
 =?utf-8?B?ai81OE01N1lvR3dvazNZYWRVblNFTXAzZUdxNWk5MWJaN2Rzd2thTHF0K1RR?=
 =?utf-8?B?bFQzVzIxTmdpYmJlbWk1TzhXS21EMEJVR2tkSzllUG9hMWxEMGJJUUlSNmsr?=
 =?utf-8?B?N3krRFFoTDhtNmJ3YUFNUmVNeUhLUUorYXFOVzZoQWZSeTd1Ukphc1R3b2Y0?=
 =?utf-8?B?S29ueFVDaUd3ZWYwZWVJNENYVkRXZnlibUF2S3lXb1dPbmgwcVRyQXhaUXB5?=
 =?utf-8?B?K2xyMUx4cTVRdmdRak9PSWdRUzBYcG12WjFxR2FJMTR5WDFRUnpIMS9QK1pW?=
 =?utf-8?B?STY3b0pEem82UDdvVDZuSnNqNWQ1c1UxRzZOYkhEc0Q1Ni9kd0h0dFczaUZh?=
 =?utf-8?B?VDFDRmtuUEV1eVEyUzdqWENmV0F6UEtGL0o5OUwvMWFNc0VYYnlIbVM1VHJp?=
 =?utf-8?B?ZTlSZk9meCsxSThmWGROc2pvNDV0R1dXRW9xSFhKWWp3TGpVVHlmdVJuMWds?=
 =?utf-8?B?Tm1hYVcvZ2NaalRJVUdaL0J3OTF2ZnZiN2VTK0lRR1duVDFxd2JpTlhrakhG?=
 =?utf-8?B?YmxPcDd2dVRqUWJRTTRvT2NHYWtJYnd6QVZGQTFHbTl2dHZyMTlmQi9ZZk1B?=
 =?utf-8?B?Qjd2ZVZoKzZ2YzkwNG9KdXB5b09tZzlvaDVvQ3hORmVEbU1vOXZSc2NFcEpN?=
 =?utf-8?B?WUJ5S0Z3UklrTWVFcnQ3THRDT1cxeFVyeW5PQU5CMUJIVUl6dmhXOW9pM2sw?=
 =?utf-8?B?RDRPYzRYNTZRRU1Ca0g1UCs0bGVhWGpVYm5zQms4NDdsR1lBTXNmczFWQUxR?=
 =?utf-8?Q?dY/R/CA3W2HywJCWZTcDbDv6sEwgGkGhsZmrA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWpGb1kwRWs4VWxPQmw2YjlVUFo1NXBSVExmZlY1akViWG16enF2TnpkbGVv?=
 =?utf-8?B?anV3RnhEbzJXdFg3eGxmSnhoYXdMY2g3RThBT3JieXlvVUs5THVWSURpSUhC?=
 =?utf-8?B?bDJqazNXYkFULzlHeDIwby9EQzF6OFo1NS92N2ZWMmVNL0RxRjd1U3FveExW?=
 =?utf-8?B?UWZScmxzb1BCNDUwMGJ2R0doRVBMRHBreDM2c1BzNEI4Q05MRi9QQ1JYakR3?=
 =?utf-8?B?N3A5VWcweTBLajdHMFVPZFNtZ0tGZmE0MitQMno5b0xFKzh4aW1pVU9aRmxk?=
 =?utf-8?B?bDk5UjdJdFp0eUtocGtacGRYZnB6eEZ1MlRmNENhbHhub3M5SWdDQzdjdWFY?=
 =?utf-8?B?dzhudlRUU1hzMzhiUVdXS0pHcWZkUVJyTUpJNVZyRWNpbzU5MmRRdjNxOUZv?=
 =?utf-8?B?Q1dSMjNQQmNpeTFvWkJINjM2SVEyWkFoNnRFa3NKNDJ4ZWN1eXMrK28yRVVB?=
 =?utf-8?B?RlNvUW1MWm5QNWgzU2ZibnZDU1hJc1NjdUVYZmZUODVkaC9kRzY1SXQ1Mkgw?=
 =?utf-8?B?anRjdzNmcUZkdFdtam9wNGxCSUJERHZkd0h3ay9nN2t4Mi9tYThXbjdVb2ZW?=
 =?utf-8?B?bDNwL2Z3ZE41K29nY1YrNHBGaWhGSnZkQWR3bzMzSnFzODQzYUFYV09sbDZO?=
 =?utf-8?B?UEpyMm94RlpSYXhvQnNFWVNTMGVMbEpZWE0rWjZVcU5SYm11Zys4R0wyNlBK?=
 =?utf-8?B?SXZ3bjM4ZWkxUmpKWDFIdFBwV0dPQ2lUcTd5cWtGVFh0VDVwckVrM0h0T3li?=
 =?utf-8?B?RHM3c0dtb1RzNDY5T2hnNEhaQ2U3YW0wQnZ3Zy9KVEw4eG9lNGRjYXpIYjZI?=
 =?utf-8?B?K0J2TXBuOGRlNXcvc1M4TGw3dUl0YjdYTFJsaXZDNUFRTVloVFJ3SFNtMUcw?=
 =?utf-8?B?VWlkbCtkR1ExdDUzaFMwb1VkS1NTWm5VTm1ZRngrUENlbFZMVmM1RUo4a1o1?=
 =?utf-8?B?QUdEQS9ZV2tzZFIzbHNyM3FnTHNQTkhvODlFelhuei9IcmVPYVpvcEpTYUhv?=
 =?utf-8?B?d3BaS2lEdHplNGdnZVVaYXdvMXBZbEJaTW5jcE52Q1J5MzlCUWV3N1NBSGdI?=
 =?utf-8?B?MnpZOUJvenkzcC9pM3h5NHcxSUVUa1VVZVozbi9UcGtxTWJkYVMzVitPLzVv?=
 =?utf-8?B?YzZZZHNHU0JYZE5IWTk1cDgwRlFzOTVhOC9KZlNZUXpIVTZ4S29DaWlGOHhP?=
 =?utf-8?B?R0lBNXZYWUt0SFdZa1IwdlJUR3hwMlBEQnljanVCQjhXYUwrekhnTGRzR21V?=
 =?utf-8?B?aHJtREdMaXpzN3QvSWJTa1BXU1JtU2RnL2MzTjd2UmY3aEZndXpnTjdnUi9j?=
 =?utf-8?B?R2swY1RUTGhmbC9lYS9OUC9kdGMwMmVyMitDSVpiczZ6bW80NnB2R1A0SlVB?=
 =?utf-8?B?NU5uaS9IcjgxcCtSTk95anVhcENmem0rZFMwUmxXbkRCTEhTTkdJcy9LcGx1?=
 =?utf-8?B?eUsvd1YwVDlOanl1S256SHFta2IyY0ZqRWxsM1FCMXJCOVJudklKMXdGMmVs?=
 =?utf-8?B?RHU2aStmQUtpRWE2S1o1R1Urb2dwRHZibDVoc2w2ZHlDeDNOc3lPNTYyUkVu?=
 =?utf-8?B?aEpRaXBpajVnT2dneFBnRmZrMmZic2FkYmpKVksvTmNqUGNlNm5FaUR0M1V3?=
 =?utf-8?B?RTM3N0UxSU9RMmVTUHJmdERnTW13a2dKK2Q1ZnZXTGQxOXAyUWJSbFFoK0Yz?=
 =?utf-8?B?eGVKaU9ZR1ZyNEVYQ3QwcmI1VndEYVdtSG8xRERXeDIwS3NzWE5hdjdaVjN0?=
 =?utf-8?B?MEJjYzZ4SWVFdmhoQk5DSkhnZjFXcWRKSEZ5SmNWWitNQWRQdjF6bEJGcEwr?=
 =?utf-8?B?eUhyWmhSeUJMSmNmNFBSMVJFcUkyYTBkUTgwVHdYRTRlOFlDbG5LSnk2NnRB?=
 =?utf-8?B?My9aNmpkdHM1M0ErRFFWeFVqV0hxY0Z4ZDY3by9BOHd4UWYwQ1lRUGgyVG9v?=
 =?utf-8?B?QUczYTdFcDA1RDkvYlJuQmFLaXIxa2I3RFpaQlJtRU11cDhQZzlYNjRUMDlG?=
 =?utf-8?B?TldyTXlzdFFsTFNFSGJwTmhaakJqRzJ5Vk5PSnh6cGY5SGVBK2sydTR6bWh0?=
 =?utf-8?B?Qmd2WGM3SjRwZ2Q2V0hsa3pSbkNLbmwrQVc1NG1qY2ROb0JYZEZmOEJzcFpp?=
 =?utf-8?Q?tnK7vbyOr5NGXWDRNrFdu3xLh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d980b72-48f4-45ad-4787-08dd03f23905
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:48:22.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0rCIl0BzQyhfc+fNT5MjqNKL+ktE+f05/t9RvTAG8DC88RdMvjCFu+Fk+BysKBPjXc/LSlkN9Hq384UX+4AcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com

SGkgWWF6ZW4sDQoNCj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29t
Pg0KPiBbLi4uXQ0KPiA+IEBAIC0xMTQ0LDcgKzExNDQsNyBAQCBzdGF0aWMgbm9pbnN0ciBpbnQg
bWNlX3N0YXJ0KGludCAqbm9fd2F5X291dCkNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJLyoNCj4g
PiAgCQkgKiBTdWJqZWN0OiBOb3cgc3RhcnQgdGhlIHNjYW5uaW5nIGxvb3Agb25lIGJ5IG9uZSBp
bg0KPiA+IC0JCSAqIHRoZSBvcmlnaW5hbCBjYWxsaW4gb3JkZXIuDQo+ID4gKwkJICogdGhlIG9y
aWdpbmFsIGNhbGxpbmcgb3JkZXIuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSB0eXBv
LiBJdCBzZWVtcyB0byByZWZlciB0byB0aGUgbWNlX2NhbGxpbiB2YXJpYWJsZS9pZGVhLg0KPiAN
Cj4gRm9yIGV4YW1wbGUsIGVhY2ggQ1BVICJjYWxscyBpbiIgd2hlbiByZWFkeS4gVGhpcyBpcyBp
bmRlcGVuZGVudCBvZiB3aGVuDQo+IGVhY2ggQ1BVIGlzICJjYWxsZWQiIHRvIGRvIHNvbWV0aGlu
Zy4NCj4gDQo+IAlDUFVzIGFyZSBjYWxsZWQgaW4gdGhpcyBvcmRlciAwLCAxLCAyLg0KPiAJQ1BV
cyAiY2FsbCBpbiIgaW4gdGhpcyBvcmRlciAxLCAwLCAyLg0KPiANCj4gV2hlbiBhIENQVSBpcyBj
YWxsZWQgY2FuIGJlIGRpZmZlcmVudCBmcm9tIHdoZW4gaXQgcmVzcG9uZHMuDQo+IA0KPiBNYXli
ZSBJJ20gcmVhZGluZyB0b28gbXVjaCBpbnRvIHRoaXMuIDovDQoNClRvbyBmaW5pY2t5IHRvIG1l
IDooDQpCdXQgSSBhcHByZWNpYXRlIHlvdSBzaGFyaW5nIHlvdXIgcmVhZGluZyBhbmQgdGhvdWdo
dHMuIPCfmIoNCg0KLVFpdXh1DQo=

