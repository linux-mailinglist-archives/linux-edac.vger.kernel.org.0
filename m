Return-Path: <linux-edac+bounces-2173-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948029A9432
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79EBB20DEC
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 23:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F201E377A;
	Mon, 21 Oct 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e879nIpY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2D1E47B7;
	Mon, 21 Oct 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553471; cv=fail; b=REiEox3afAtpkHv+PEF/T+x6vozYDcARjcTPmWSj7RuoOLYrSIduMe94h627pE85jXkgmlTzVFfLHtqvo0R2xW3jok76YSNeOE/AA8ZyIIFJi2XbOS6hQagSWbtx5nZ8b6rIqG+ai0Ywa2z1FZFCt+zCsrTC3KcW2RnJ5WuH1gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553471; c=relaxed/simple;
	bh=gCvcwNV8laGF2jwZ3O6pVByGR4xohhcbjYpgxEfKGOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mw9GuKWSmxXZOlF11SXzymSYlb4kjipxN9c93/Rok5rzGiP6qWo1wArNidbk5d3uuBR8Du5xzvZULkUxwftzSxIGlE7Xtca2k5/CXgCg84dTmxpjYilPG+sH4L3MJfyi33bTl5nV7LFA9ttk5IXshMx/1Xe31hEJfN/u/OscMAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e879nIpY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729553469; x=1761089469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCvcwNV8laGF2jwZ3O6pVByGR4xohhcbjYpgxEfKGOQ=;
  b=e879nIpYJt+mlKcf3poP4N30k/H79k0N02w8AECXNKrYXd03SwClOORU
   Ar7Hfmecp4REZVqTv78U8UIL+fVx3Go1P60m77rKOe/d0SMcghTTiOgi1
   BmSCDixzHP3601D6jlvN+9AJV59/ouvmxBaWSn2weMA8SU7STx1XmXfRE
   ImlptZKC7HtyqHxf1iQi93le5K0t2KHfPjQfjWjMH1aMYVIaZ0IH0A2CK
   14caW+zWfqu5H1yV7NZ9FqAlkzunHG06F8gcpvNnK1PLyvXHOkFBt0mPn
   LXk7OIhVvvLRRQGxWXuaBkkE1sAQ/tMFmO/jTL7O7VwAlVeOk+2nRpfiQ
   w==;
X-CSE-ConnectionGUID: LoLpIxyhSUCwN927SLpTTw==
X-CSE-MsgGUID: x8CI03ehT6G/5PWCcbEw3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28939623"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="28939623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:31:09 -0700
X-CSE-ConnectionGUID: 4M7sj+4dSUePqUMRfboxyA==
X-CSE-MsgGUID: jXq7z3ENRU6fEgEwY4poTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="102978930"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 16:31:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 16:31:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 16:31:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 16:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9sYFkoKWaZQ/bk6CnYC/wV3w8dWXTasla3twLZemqqoE/3p+MNlX7J4wioyaIWNrPgbiqW8QKOVbFSaCTHCGSmA1WB7uvblXueWmqxwmwiesHbjn7R0DVUIuS0hCS2jMqm/jJiiKI5ZeY2QURCbhEzOssZj+427TwD/OxOzlivJBJHLR8goORdC1B+hOBKcJzA72LPavnoAaDllJJ30fQQOia+dm7gB9DaEk9ioF56JfbpyGdVhrtpajNExeE7TNWh9eSgDLBUbxfxzVSWT6zmhxMj+mQ2AcBwXm5SYv4dZMSPwVa/CBByoKPyRY4DwXV9WQDgUsrnsqlIxU6ojKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCvcwNV8laGF2jwZ3O6pVByGR4xohhcbjYpgxEfKGOQ=;
 b=rUTsbx6HfbAAKJozuXUoCkCOj1Qods8x51TM89Y5mRw0oULKszObgcCh22ZZoaqKgiFbVr4E21bAPd2EocVxExMsEr0vqzhYZzHe79zqESCE4G3jHV0iuvOp2HAjn96fQWmSCsIkpFnkK9AZunxrw5MhqiD/sA8UUw/Ipv4aFYly2imUxwIxSSywtc5ieAYaO3y4ied8++ydOXLMEk0yF8pIUE7cNKLImoIeqORUn6eIYwHByJVKsm1XltTWis01GtOkQiKdCMGoOHVDZBxGVBSxQ/pDfkUYBb1Ej/DqdTk40PPyaAa5YWZsTkUO9rZFHdgvyYm535hDMIZsrJhbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 23:31:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 23:31:04 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Zhuo, Qiuxu"
	<qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qM4hN2vTGb8EmNSTTck992prKM7JIAgABI4TSAAF9SAIAD0KcAgAAbFACAAAC60IAADI4AgAACokCAAEkpAIAAA7Lw
Date: Mon, 21 Oct 2024 23:31:04 +0000
Message-ID: <SJ1PR11MB6083740D3EAD10DCDCA12EE8FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
 <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
In-Reply-To: <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB6097:EE_
x-ms-office365-filtering-correlation-id: 7948141c-bcea-48e9-28f0-08dcf2286e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OVV5THZIM0VFcFgrRklsVTFLRG5NYTV3SGk2YnExQXVLQVE1Y3l6bU56SjRp?=
 =?utf-8?B?R2hlWitPK3lLVHI2N25sYXdLTVhPbWpNUXZQdk9NUjhScGJheWdTaUhGbU1P?=
 =?utf-8?B?QXd2TUtIU2V3WGM2eG5CcnI2ZDE5K1loWjd2ekdWSXF2UlRZNFZzY3BjOXpF?=
 =?utf-8?B?RVBBT2xlTHlWVFgzUHA4NU9ZZ1BrU0dTVkJUbWxPd2tUQW0wZ3k3aUhPOFVz?=
 =?utf-8?B?blRRTHVCTzdkUVZUM0xlbkFFZU9SWDJqajRVTHNSVXN1N09NYWJoblIxd0V6?=
 =?utf-8?B?UjRET1pHK0I4ZjJ3SGU3c09xSEtaVE1MczJOaG9McmN0NGQ3WnZFbUJtLzIv?=
 =?utf-8?B?SmlBQ3dGUW16NDFWMVNteSs1VFhyTnpqUE1ZdzRldGdzVWZ2U3lER2t4Z01N?=
 =?utf-8?B?L3o5bXREQ3BTbm1qRXlROEowZDltSFdvT3lxMC9ORVJBU2NFQ2pHbGxJaFRW?=
 =?utf-8?B?TXc3SlAzc2RMbTkvVVBCODNYSCtSamIrM0l6VHhwUjcvdDViSE43Y1ZlRHdV?=
 =?utf-8?B?TEhYSUpBU2M3N3U1Rmg2L0c2L2pZT0JwQmpXTW1yS09pbW5mdlVZTFgvUkQz?=
 =?utf-8?B?RldUUURhL1ZxbG1HUmtMSHNXTkpGR2JJUUFUdndzRDFKR0syeEdJcDFLS1Qv?=
 =?utf-8?B?cFBjNGRPRisyaTlDeUlvM3UxSVQvT0x4L1VQR0l0azhWWTVCckgwalNzNDhn?=
 =?utf-8?B?YW83dEFMbEJCaG5YRUlkK2pkUlk5QXBXQmhBNGgvV29kbDY2YnBOREQ3QStX?=
 =?utf-8?B?YnRhMjZ5a2srNkRxMXJaS3pCUUFLYW1DWGpJS3NVNW41R0Z5VUE0dXpyZGZz?=
 =?utf-8?B?Z1l4SlpITis5ZzRMcjNjdkQ2eGxXVkdITE1jZzhjeWY1Sk5seDVacXlUZHFy?=
 =?utf-8?B?QnNNNVkyY2QzcEcxMElBT3NEdCs4MEJnWkw1Y3crcGNjQnZnWmhjck5VekRO?=
 =?utf-8?B?RW9mUFhFeXhEbHZKdHFDQml2MXN1NUp2NWc0bWxtbmRQUDlRcGRCcjl1Rm5S?=
 =?utf-8?B?dDBkcTZBTDcxWkJLVlQxOHlodDJIQlBVa1BrY0NadXNHb28rSkNzMEs5SWZo?=
 =?utf-8?B?dHQ5c1NmYzM3aFAyd2VQR203b29yMkppdCs5ODQ4QklIcEdESHNJQmI4MGtX?=
 =?utf-8?B?MVRjcm9BTFI4eHlWSy92RXlibFA4TEhVZitGL3MydTlZUkt0eWNHd3dISVND?=
 =?utf-8?B?RngrYk01YzM3blZ6WERQcDFYQUNiU0FCVFBtaGd5bmsyNmpnZ0gxSUorVUpj?=
 =?utf-8?B?a0FTbDlCQURDMFdlS0NUS1hXTGhiVlFQRzFLa0VTc3R4eVljdlVCNGpQcFkx?=
 =?utf-8?B?ZUNOeGFJN05vcUZ6OUt1ditWVUV4Mys3WDFqWTNjenZkTEtiMXZSV09abld6?=
 =?utf-8?B?U3I3KzV1WlFza25QQUl3MlF5Q1FIeVRkRUt3WDFJUWxsenZocWpFSW1MMDZ1?=
 =?utf-8?B?SDdHeEljQ3dxTFJ6VlRER3Rud1g0TlZBc0pFRjJSTFBJS2VkMGJFMkRZcUxX?=
 =?utf-8?B?RVZzZ1puOGRRaUpmeUpVVjZXb2JKcngzczBEVXN0U3pJK2IyV2VBNEJjSU9O?=
 =?utf-8?B?ZHJRREwzQ2VLZW1jUWUzRUxlUjlkQTZTbW10QmswQ1QrbE1DVExaQ1hVTHBk?=
 =?utf-8?B?MjFuOHlnUDAzUE9PU1lnS2xnTCtKRWdVdWVIbGNoSFRNOVFWMjhBcXdMei9l?=
 =?utf-8?B?SE5BSzRmRmo2TmVmVUcvWTRSR1h6b0hLMzhhUVBOcnhpWjdVZEYwa3JTWGlU?=
 =?utf-8?B?THlXTXp1RUpCZHR5TDg5QUM5SERUMEF4ZC9UZFFRTUcyLyt1WmpMekwzRDl0?=
 =?utf-8?Q?9Iaopl9977uZL6WXKhQAc90BdYCzLiHCFnDJE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9CSzY2TkpiUnVXMFMxQzUrVmFpeWI3czErN1VKNVJWL1RGalozV2JpYTla?=
 =?utf-8?B?OTVlMzNqV0VUR2U4VWJNNHdJb1NxU2s1QzdpNzF2WkxwU21TU0tQMXNzbjJK?=
 =?utf-8?B?aEVBcWxJMUs2eVJ2UzlYS3FtS0djcjVZMVVnVnd6UzRzTmhuRFlYQ0k5TUs5?=
 =?utf-8?B?U2R6Wk5nRmpOVFBkN243dFpTZkMzaTZFVWxqZzVjcDhtUjd1L0lJOUpmQmJX?=
 =?utf-8?B?VGFlYjV4R2MwejVZdkhoVnlHcGI3czkvaFhwL1NhVXBpWFg5a2hOU3RST0Mv?=
 =?utf-8?B?VFI2MlYxRnllVngwd2xXUU9QUXBrRDlRVnQ5WlcraVZOZmVQODhnbEJTNVlY?=
 =?utf-8?B?Sm1ubkppaUYvSzNyMmNTdTl6ZHVNY3RqQ1hLZGxkaWdSTFJpWDRYZ3VyeWVs?=
 =?utf-8?B?QWtHVUs3Y0toZzNDSnhkNVg5N2ZjYTVpMWNxTDF0dXROMnd3WmpmWVpJQWhR?=
 =?utf-8?B?THVsa1BYQk5RNWVTcDhubjZyS1NlVFNScklGQmhCSEJuZEZPbFFra3ludjlr?=
 =?utf-8?B?WmZScGJkQmtRVWFnMmNLeGVERTdGSjlIaWRRRldDK1hhTzhyOGtqOW9YRUND?=
 =?utf-8?B?Qk55NmhFVFZ1cWMrdDFxOS9tVmFydU1ZcmJ5OEtuUVZSMXhZcVhLTS8vajJK?=
 =?utf-8?B?djhFc1NoSzFiNWpJZE9CNlo3eTZYY0Uxd3k2aUJjbS9EaUNmUjNoM3NmcnYv?=
 =?utf-8?B?QUpITWlsZjM0SjQ4UWthektZdFFuRkR4anIrWC9td3RrK1BIQjFKU2g3bnp0?=
 =?utf-8?B?c1NGbmk3VjlJUllld2pUeXpGOVlSQmdzOVhHeEFTTU9JcUhnY3pnaG5ZQzgv?=
 =?utf-8?B?aFhqS1hZNWU3a3NrQnV6YTJlNEY2U3EzK1picEFRS0RKUVlmSWJCdVFINStP?=
 =?utf-8?B?TkNXcS8xblpXQmZqUDArQTFzN0NWWXNrazFaVFd1bzNoRWtFQTZ6QkZBZ1Ny?=
 =?utf-8?B?WXZKeE5TWmZ5NVlodGdka3VVNmE5OU8yRWxhNkdTb2dTTVVvV3Q3RURzUERs?=
 =?utf-8?B?TmF6ckVtNnA3MmpGeVZTNlRRK1lZOGxwTVJ4NzBrYWV4S2x2aUM0Z1JaTEMz?=
 =?utf-8?B?THlnTnFIbjQyUEloU3pwZFdJWTRkM2NBTWo0bHhybGdvWGJLYzlBanRjZXlQ?=
 =?utf-8?B?VForbklURStqYU9GVUk5WEFCQ0VERU9jcEZQcEY1NnZlcE55S0pNSHpBVStU?=
 =?utf-8?B?cldZeUd6Mm9QNmtNQzhMM0tNMmUrWlNIc2R6N0J4TFZFTFRxOStvYndCa3dY?=
 =?utf-8?B?bDNzeENPV01MSG1uTTBOcmtObTdJeHJjUFN0NDFsMUdIQk9LMk5CNzFaK2hP?=
 =?utf-8?B?U1pYN28yK3N6NEVucHRDN3FCdUtVUjBqWHdaL1NPR0EvMjhOQ3l6emF4RTZ3?=
 =?utf-8?B?Vzh2SUhJRURNbkxSMCt2RHZQVWc3QUdzbUNyWnFHWk5UVTI4YkM1YmZJR0dI?=
 =?utf-8?B?elJlV0g0bGNML1RheWdsVUJwYjB4S09nSXdFdjV0NFBuZUs2eUs1Mm55bmdp?=
 =?utf-8?B?TTk1R3VDOWNJUlc2cVVBV2FUdmhtb0RZUE9QVkNiNnU0V0FUWVFPTWswcUtv?=
 =?utf-8?B?aXJQdDA0NTIxNk5yYUVoTHZIbC91SlVmaXlBWC80ZHpPQmVTc2YvOXdkQkx3?=
 =?utf-8?B?MG1icFh0SkltUHhrbzE0UmhXT1VCUXJFRzE2NnBuUVhJTTU1ZW93YlY3bWpt?=
 =?utf-8?B?NVZZR0FqVlBBZE1kdWlXLzVRUGJNc1R3eEdGb0xYWVdtZTZhMUZPbWdNT0dJ?=
 =?utf-8?B?UU0zejYxNzVTa2VDYitmUEtmME94WWg4ZDV0b2JOaTFxdmk5bHJyVlFNY0Zi?=
 =?utf-8?B?Q0FIQXFPdDdoZUdEa0xZTm5JYlFxNWxYRi9pbGMra0FlR3hEV2FGUFhwem1a?=
 =?utf-8?B?YnZ3UnVYUUUxVG85SHVudjNrSklPb1VJT0JCazVMY2dXbWNaN2FZbXFVWmZG?=
 =?utf-8?B?bXhJVmxHTE5hUW5KMFBCVVNqYmRXb3FmRTBnVVg0UXNySFR1WDlTVmZ3T1ZS?=
 =?utf-8?B?RitOeFFRbVNJbmplVEVQeWZKTWgra1JPMnBsMmxUajVQVXVDeERtWWdPQnUy?=
 =?utf-8?B?VWcyUjdtbW5yK2VQTnhZTUFsNzdjb0xOdjZaczNNSVFCdDVMWUVNQjlOTkdo?=
 =?utf-8?Q?pofjhyFImhCSG89x8vumAtzb/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7948141c-bcea-48e9-28f0-08dcf2286e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 23:31:04.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4I9aJAFnm/aYr4K1E7uY7YLNVQVJgxtuEegrJTpYkRG8ul44FEl6VyFq3vOUcV1o+yJXAEWKsIZrQXIupxk0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com

PiBUcnlpbmcgdG8gdW5kZXJzdGFuZCBtb3JlLCBJIGhhdmUgbW9yZSBxdWVzdGlvbnMgdGhhbiBh
bnN3ZXJzLiBXaXRoIHRoZQ0KPiBpbnRyb2R1Y3Rpb24gb2YgRmFtaWx5IDB4MTksIGRvIHdlIG5l
ZWQgdG8gcmVldmFsdWF0ZSBzb21lIG9mIHRoZQ0KPiBleGlzdGluZyBtb2RlbCBjaGVja3M/DQoN
CkRpYW1vbmQgUmFwaWRzIGlzIGluIEZhbWlseSAxOSwgbm90IDB4MTkuICBJIHdhcyB1bnN1cmUg
aW4gPGFzbS9pbnRlbC1mYW1pbHkuaD4NCnRvIHVzZSBkZWNpbWFsIG9yIGhleCBmb3IgZmFtaWx5
IChzaW5jZSBvbmx5IDUgJiA2IGFyZSB1c2VkIHRoZXJlLCBhbmQgdGhleSBhcmUNCnNhbWUgaW4g
Ym90aCBiYXNlcykuIEkgcGlja2VkIGRlY2ltYWwgdG8gYXZvaWQgMHggcHJlZml4ZXMgZXZlcnl3
aGVyZS4NCg0KPiBlYXJseV9pbml0X2ludGVsKCk6DQo+IGlmICgoYy0+eDg2ID09IDB4ZiAmJiBj
LT54ODZfbW9kZWwgPj0gMHgwMykgfHwNCj4gICAgIChjLT54ODYgPT0gMHg2ICYmIGMtPng4Nl9t
b2RlbCA+PSAweDBlKSkNCj4gICAgICAgc2V0X2NwdV9jYXAoYywgWDg2X0ZFQVRVUkVfQ09OU1RB
TlRfVFNDKTsNCj4NCj4gSXQgc2VlbXMgImNvbnN0YW50X3RzYyIgd291bGRuJ3Qgc2hvdyBvbiBE
aWFtb25kIHJhcGlkcy4gRG8gd2UgbmVlZCBpdCB0bz8NCg0KVGhpcyBsb29rcyB0byBiZSBjaGVj
a2luZyBmb3IgUGVudGl1bSBJViBQcmVzY290dCBvciBuZXdlciBpbg0KZmFtaWx5IDB4Ziwgb3Ig
WW9uYWggb3IgbmV3ZXIgaW4gZmFtaWx5IDYuDQoNCllvdSBhcmUgcmlnaHQgdGhhdCBpdCB3b24n
dCBjYXRjaCB0aGUgbmV3IGZhbWlsaWVzLiBCdXQgaXQgbWlnaHQNCm5vdCBtYXR0ZXIgaWYgdGhp
cyBsYXRlciBibG9jayBzZXRzIHRoZSBmZWF0dXJlIGJpdC4NCg0KICAgICAgICAvKg0KICAgICAg
ICAgKiBjLT54ODZfcG93ZXIgaXMgODAwMF8wMDA3IGVkeC4gQml0IDggaXMgVFNDIHJ1bnMgYXQg
Y29uc3RhbnQgcmF0ZQ0KICAgICAgICAgKiB3aXRoIFAvVCBzdGF0ZXMgYW5kIGRvZXMgbm90IHN0
b3AgaW4gZGVlcCBDLXN0YXRlcy4NCiAgICAgICAgICoNCiAgICAgICAgICogSXQgaXMgYWxzbyBy
ZWxpYWJsZSBhY3Jvc3MgY29yZXMgYW5kIHNvY2tldHMuIChidXQgbm90IGFjcm9zcw0KICAgICAg
ICAgKiBjYWJpbmV0cyAtIHdlIHR1cm4gaXQgb2ZmIGluIHRoYXQgY2FzZSBleHBsaWNpdGx5LikN
CiAgICAgICAgICovDQogICAgICAgIGlmIChjLT54ODZfcG93ZXIgJiAoMSA8PCA4KSkgew0KICAg
ICAgICAgICAgICAgIHNldF9jcHVfY2FwKGMsIFg4Nl9GRUFUVVJFX0NPTlNUQU5UX1RTQyk7DQog
ICAgICAgICAgICAgICAgc2V0X2NwdV9jYXAoYywgWDg2X0ZFQVRVUkVfTk9OU1RPUF9UU0MpOw0K
ICAgICAgICB9DQoNCkl0IGFwcGVhcnMgdGhhdCBjb25zdGFudCBUU0Mgc3RhcnRlZCBvdXQgbW9k
ZWwgc3BlY2lmaWMsIGJ1dCBsYXRlcg0KZ290IGEgcHJvcGVyIGVudW1lcmF0aW9uIGJpdCBpbiBD
UFVJRC4NCg0KLVRvbnkNCg0KDQo=

