Return-Path: <linux-edac+bounces-2337-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0679B5938
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 02:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01491B22170
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 01:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6205C146D40;
	Wed, 30 Oct 2024 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+GbR/9N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B8B661;
	Wed, 30 Oct 2024 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252390; cv=fail; b=A4K1StTjX2vdGcqspRTmm9hW2fiUvdwM8y55Ar9OlHqONjvKn53J+N1BueuxY6YJgZobSf0MFXdNltSpEVquj9czix30BMCE6FYAK3Q4oy/1jOs/STFgsPkfGbSoRvqbRarxJajGAMrvUsyYcnddRerSdXSMTzbA4tjk4njh0Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252390; c=relaxed/simple;
	bh=8PhYZhX0vl06s/BkxQ160wGIqbZpzOLr328PAf2UmbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GeHTt30HQoFScfS/0fzYYrQgxiU8UVHfMJchjcpVTcGsgtByskdEYDOeJx9AjU5NNJ8nGheZs+fX2rqSRkPFTFdm9FH2pCIzOrZGaUSockYf6U58vhjQ/z6Qe6+JceUIz343DAX5oOAl1+ZItbTp93qksr+WKmhw3k6Xdn3yKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+GbR/9N; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730252388; x=1761788388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8PhYZhX0vl06s/BkxQ160wGIqbZpzOLr328PAf2UmbU=;
  b=E+GbR/9NUu4CMyv7hzT2a4jKZoBd00YEwauiu6eeyzCBG98aqrBmFRoQ
   vMHyVzAh1eLpgp+XouXs9mHk50yTYgqjns4hw3Q5Al9UzbPOOitP6l4Jz
   ZGhVyUsC96HEyDIBZ612Zx57GWSWm2qdXfoRezZtV32++gpLrnQLskJup
   q/NRq5q90i3a9+KZVNTSEX2T5DRlSjDXzssc6LbDockcdm3HmFcK5jmre
   AwPHty21ADzd7cc6XFrrzVWChPUnN3TOleuUFq8lW5huoOL2FWqpp3ZLL
   Eg+lkGmmjVokNfu9vtR7Ko3i8VUc2Kz5j2pnyHvaV3pV6iNu05+r+Aif+
   A==;
X-CSE-ConnectionGUID: 3Imb3sgnQJyeXWMolNc1AA==
X-CSE-MsgGUID: dQ9PFSMARQ6yTd8HuYIAPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40465036"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40465036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 18:39:48 -0700
X-CSE-ConnectionGUID: R+xdQRiDSE64LsZX73M3BQ==
X-CSE-MsgGUID: oyNRKg6FQ5y79d4lNKzpeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82315376"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 18:39:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 18:39:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 18:39:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 18:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrc/tmL5LgEaE9K4ZBZr9IkAlbpsvRH9JkZoBOi4DW/y+Wjx5Be4DdsR1/6Oj1+BCeeoPnXyvD+eP9J4gE8+WzBvAx51tZlS/0z3bhL3bCsSUX3saqgI5T1Ld5wU4HbK1i6eJmlGYO9102k5YysQ1iyCS5HFDs9WD86EbdzQEGicg7n0Hzy4+ZnaCnvtFGoaxAR0jtlPCJSUwxWQn6tbJpmW42C7QvKCB+N/cdMAQkYt7ZLeC9Ln/QwWhSmA5qOif9ez1mwKH2+JCC0SHJ1For1SFkj6PODTiQzc63BsB46mr3gQdf3fZQqxvn6T0d54X3YxxfZU1YzoH+yS6pEAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PhYZhX0vl06s/BkxQ160wGIqbZpzOLr328PAf2UmbU=;
 b=ALarXBAoRZcihSpfg5gAtAHr4hNUhGVXS7Z0AOnB5Yo79s9vBTqGQTkzj3IloRoQ8lEQ19Qqv+EJIB4ZvqcozLAKP4+yhSyt5A94Woreld9N06uXcVuxddpv9TQ1o34F0sZt8tS02eqJp9qaJS6au7136+hvzxDMOwf/rS2hNV5LaGlcStbwtnxU9HvAHzumTNmAKHoKkAO2nm93bmmDOIZCCsaiVEVIpZxjHLDsO9tMdcwRoWqbfTnvKYj2D79VKfV/45pZ9/9ht8bEYof41dZoIWiVt3FFfAVv7FhoJvEnEj2gNmMUT6lyStCVakUBVJfVp1F0kJj8P+hqInb2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV8PR11MB8724.namprd11.prod.outlook.com (2603:10b6:408:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Wed, 30 Oct
 2024 01:39:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 01:39:43 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Thread-Topic: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Thread-Index: AQHbJougQzANe61d80Cc92LJLibtebKeSO4AgAA7hUA=
Date: Wed, 30 Oct 2024 01:39:43 +0000
Message-ID: <CY8PR11MB71344FF8D9EA706AFA74618A89542@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-7-qiuxu.zhuo@intel.com>
 <20241029213920.GB1229628@yaz-khff2.amd.com>
In-Reply-To: <20241029213920.GB1229628@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV8PR11MB8724:EE_
x-ms-office365-filtering-correlation-id: f8c52603-e20d-4897-c4e9-08dcf883bac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3k0WXpIOFg2UTU0TG5UdmltRlRadW03OFVMemo2Z2NzdW9iOUhpTEswcjFu?=
 =?utf-8?B?SkkyVG0yMkFHcnpHYk12T0lhZTU4RVJUWkRWUERraWVKRkdFQ3ROaVdFVFRz?=
 =?utf-8?B?ZUFTNVFrV0ZKMWE0bWpVTFIwRmpqcE1leEZFNFpjK2NSOUVTT3FmQlVSYmpn?=
 =?utf-8?B?dUpzWjdZT2lZN3JRQTdyUUJxbVV0dG9Dd3NkaUtYcVVVcUFpWkZWRGtzeERR?=
 =?utf-8?B?ampVdzRuZzg3ejN3TEJwdE5NUnUzTUxjS0lxN1pIUkpBOEE5YWJsZjdrc2Yx?=
 =?utf-8?B?N3B1aEJ4eHdGbGR0bi9pdWEwb3YrOERPYzRCYTgralpncDJDcER1VVFFd1lG?=
 =?utf-8?B?UDVwbFBIeEtTdXZ2ZUo5K1pEV0pGU3krUk9ibVVKT3JTWlUwMU03WXJWckZL?=
 =?utf-8?B?VnhpUFlQemlTeGJ3NVpBdXJuMldiNGV5VjEwMy9KUTZtVUs2eU9NbHFhVWg4?=
 =?utf-8?B?a2ZkSXNsVEViTkF6TGlvRTQ5N2VLbkRwSTZKbXZNZmRCVVpHcXJVVEhKTnYz?=
 =?utf-8?B?OVF5YVN4bXBvM3Y0cTRpSGVLT3hVREV6Q2M0TTlPZjFWZHlUM2V1UDlLbGdl?=
 =?utf-8?B?QUx6Zm9tNU5hQzNRdGVDdWd5eUdnNG11L0wrZlN4SUhXQnBTRXVWTTBzWi9y?=
 =?utf-8?B?aXkzQ2lZNHFzdHFRcmxoTnZMbUJuYkROdUM3RnFTZ2dod0FTYTZ4N05FOUFJ?=
 =?utf-8?B?RERaSlNtbHhwRkN5RkJuOGp6c2hXMVdINDhZQUxqWStHNDFxL1hTVmJGa2sv?=
 =?utf-8?B?cWs0Tk83ajlyOTMrY2QyWTBvY05WUHNUM0JuZUNUS3ZPVE5YTFNoREJmSlJu?=
 =?utf-8?B?Q1RMMi80dWpaZlBPQXNPeWphVzBOM3k0VDZrclF3S1hKdDZRWWxXNFh3RHBt?=
 =?utf-8?B?ekR2Z0YzYVBvNSsyQ2FMSmRaRHhrTlBUclAxL1dqQWZjTnJ6cWw3L1JpdW1U?=
 =?utf-8?B?QU4yMDJOdDYwOUY1S1dkdC9zMmQrdnBsOHUwSWpPWVcrYjREaHp6aHpRNElU?=
 =?utf-8?B?eTZQdzhSaXErM0E1dU9Ld0FueGRybG1iR1ZIQnlnK3laeGh3eDFuK3ZlVlkw?=
 =?utf-8?B?eUdGRWtPV2E5TjlISUROYXpYRXFWZWlSVjdGcEozSGFNc21PUzFrSWxKSm51?=
 =?utf-8?B?cGlZZ3ovbk1wOElHNmo0SVA0dFMvbmZPWTJvOCthcEQyTE1XenVZQnBtSThn?=
 =?utf-8?B?bjdpYzAzQWNyelRZOUVuMDNnYk1GWTF6MGc4dDhnWlFYbGpEYnQ3NlFxcVRm?=
 =?utf-8?B?SDIxSzNoV3VBc0JpeTIxNnR4QXhUWHZQREg2cHNjVWZrQkYzcWFyV3UwMXZO?=
 =?utf-8?B?eHJ4b3MxMDlla1JBMDY0OUE2ajVMQlJoQW1yaDJ1cDZ1MjNHaFcrd3ZUUVZD?=
 =?utf-8?B?QkVBdHFCaWh2Mk1sRXczTHEyZTRsS09CODZKWE91bkUwaWZlZmlpT21Gczdx?=
 =?utf-8?B?UTJaNG55c3BVbEF4MlkyY01RcE8yRGxIVXBBVldJOWtLQXFNTVBFc0tFYlR5?=
 =?utf-8?B?bU56bkZPTnZLNmJPUFNmQS90NWd2WER2YXRLeXhSNHN3Nm9sM3dQenNlSnVr?=
 =?utf-8?B?STl0WnFLaXZLVklsbkFqbDFzTkNnaS9rbzIrQkJzcWl0MGNYVWpjOGNGSjNv?=
 =?utf-8?B?eFZLTk5zMitoTE5sczdiM2dWWUVYc29hM28ycnp4TDR1YmljVUI1eU5Rc1Fh?=
 =?utf-8?B?WkYwWlZaeXNyTmNiRE91cDVoWUtWSkhlVUFtSkxzcW1UT0xXdjd0VUlFWlNU?=
 =?utf-8?B?UkxmL05PQWpVaUFNMVlsaGU4ZXErQnZCOE9zaGxjakZBZW9ySWF5V05Vb1dX?=
 =?utf-8?Q?ALAUFb4YKf9MfvAC2pv8cTl/zSExfvXjkXoLA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZ6b0tJajNqTk41RXJWYkZBb0cxejlxVEhWdVJqSlJkZnJuVXlUV3NUL1FI?=
 =?utf-8?B?Wm9kbXZBNDVHc21GL25BaERwaTBCSUlSRFhJQmxFVzl1UFBMN3NtQk9yQmN4?=
 =?utf-8?B?Q2dFcXZFVHdnUmsvdkx2NnJkV1piVnRmYkNWQUsvcVFIM25HMmdFK3VicktG?=
 =?utf-8?B?TUFjMG15aElhMm1RUGdwR09aRzl4YnVaU1F5bk1Wb0xXakVyajlndU80RmZr?=
 =?utf-8?B?VlJnTVVnK1JEK2tNTFV2WGRvd1N5QWVvbFNjdC9lemRzZWxldUE4OTZodzBu?=
 =?utf-8?B?N3lmOS9FSEF0VDVVN3BqeWlaWDRFeUFySWNVS2pqNlNkcFhZVFhnUEpYeWZZ?=
 =?utf-8?B?Mk0zVE04c3FSOGErUjRGZzJ0djZ1YXJ3WnVMMTY2LzlhMTJBTEJnWWdWQUxo?=
 =?utf-8?B?Znl5VFJrMUpMRHUyNUlDc00xZ2hpRWdlNzNBQ1NHSTFSY1lxdmM5a08xWlM4?=
 =?utf-8?B?SGxaU2k1ZFVMT1dCY3RjL0NFU0hCaG14RXROWkpmUFV1NytBUURoTkRGSHM1?=
 =?utf-8?B?V05XMnBkd0xtRFkwRXV6VUVrNHlmS1ppNXIzaTMrKzFuTTYzbFVkdWJ4UHE0?=
 =?utf-8?B?ZzFyS0pTZmd2b1F0c1dyR3lqalM5bHNSNUZHZFZlVmVBZEdmVnNVRk8yTnZX?=
 =?utf-8?B?MnBpaGg5YjVvTTJjcndmMmNEWWMzcTBUUHVaUmVaeW1LV2pySE9RaHpVQnV3?=
 =?utf-8?B?ZDB4WGxSZVRYZW5KbExpRHB5dE94c0w2SXVtMHN1bWdOVXBEZzNDN3hQTmEr?=
 =?utf-8?B?Vmg5Mk9qcUdIRlBXSXJkQm0wSnN3TmN3elNYZ1JEeWJhbnppbTVsOUFPU1Nu?=
 =?utf-8?B?Z2FGL3V2RnhBc0hsSG9ING43WGNIeE10Z1h2OW11THdwNTBvdHBqVTFXS3Nu?=
 =?utf-8?B?RFVmTDJORFJFN01LOHZWMUUvOE1XekhGNVhxNXdHY3VhRUlraWZaYjBWK1Nu?=
 =?utf-8?B?UzBEUUNOVXpYeWd5L0FJaXdXTVlUTUlvWE8rSGFNUWQzZ2Rmb1ZXdDhjcm5J?=
 =?utf-8?B?Wk5vUkQrUWpBZHhhdzRYYmNTM3NZTG5SQ2dKZlRUN3pSV0Y5MHdaczRhSFRo?=
 =?utf-8?B?a3VPSnQxYmZrZFl0OVR3cHJxbTZna0V0ekFFWENLcm9zNmlJUnBFeGwwQjhh?=
 =?utf-8?B?bzYxa3BMODl4eVBMODNGdUFkaWFEYlg5cFZGNVBKb3p6MWN2YjRzNTVzekR5?=
 =?utf-8?B?WUxCVVFYTUVxaFFRS013c3UyYXM4aktaZ2NUTjk2cGoybnB6TTFrd1dkYUh0?=
 =?utf-8?B?TDFKM2MwbXNKblZKcTY2Yy9zZEwybVBIUlRERTE1YXNGYVFOS3RDeDllV2lO?=
 =?utf-8?B?U2luWU55V3Y0SEtPL3dPeWxjZlA3bDZhRjUvVkszM051b1NyLzZSS0pGdnBz?=
 =?utf-8?B?dEQwNXRnNHMxYTBmWWVjK21xaHNQSzhHRzNkR1dHRDVUU25jOVBCdHJIV1Ra?=
 =?utf-8?B?WGRCN1hjRUp1S1BYWjlCbTJPVFArTWpGZWZLbW1JZ1M5VzdOemJyQ2tKTkhV?=
 =?utf-8?B?cWRiSENqWlNFSjJJaXBmNHZtdFRZeGtzQXpDeHIzeXkzYVExMUFvYmlNUnlS?=
 =?utf-8?B?a3pOZk1oT2p4MC94djM2Vi91NWpzYmhCbFQ0NWoyb25zbmF6a1VzY2RZdkRH?=
 =?utf-8?B?QXhBTEdnSy94VnUvSWhYV2VRSUI2MkZocWRlVWNlTEZJaTRmT2Yrcnhod3h4?=
 =?utf-8?B?dFc2ZzFHMlUwZlhscE5FSTN6QkFZdDVjbi9nV05NTlFoa3I4T0dPT2REOWFy?=
 =?utf-8?B?Y3pvT1FNZlZHYzJXUXlpcWN6ekZmV0kxdm85ZU4yOVRxU2JSR1YrVHVlQy9w?=
 =?utf-8?B?UDZKNUh3S3N5TXdzKytjUjdyVUtaSFkyUWZBZTBuamNBckhlaUp1M0JhczFY?=
 =?utf-8?B?UmV2MElQWnJmRHByNEllMXBVSFV3dzZoYTJZSkRXaUJIUUZHTndpc3lVNWZQ?=
 =?utf-8?B?UUtJK1I1WGc3VkRSZjB3R1l2aEtQNDhJN3FZYktKWE5OYVpVSk41MlZCRVBT?=
 =?utf-8?B?amQyOG9zbjRUUUlWRi9sWWtDSmVmajFDYzdnYkFGam1Wc0VQNkUxaTk1N0do?=
 =?utf-8?B?TjF1UkFHLzFETUZUNTFWV1U3SEFXVDlmY1c5cmhvTzJ0US9VczRONHZXMFpV?=
 =?utf-8?Q?mI+9PzOsoont4WZses5CbIAxv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c52603-e20d-4897-c4e9-08dcf883bac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 01:39:43.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRfkErywULBLRo26FYglUMfm2WBmvX4nmVhdLX4/MJTapz0HNnZF19Y5PffrA9zpocHb8I7BNYMx25N94he2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8724
X-OriginatorOrg: intel.com

SGkgWWF6ZW4sDQoNCj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29t
Pg0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgdm9pZCBhcHBseV9xdWlya3NfYW1kKHN0cnVjdCBjcHVp
bmZvX3g4NiAqYykgew0KPiA+ICsJc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgPSB0aGlzX2Nw
dV9wdHIobWNlX2JhbmtzX2FycmF5KTsNCj4gPiArCXN0cnVjdCBtY2FfY29uZmlnICpjZmcgPSAm
bWNhX2NmZzsNCj4gPiArDQo+ID4gKwkvKiBUaGlzIHNob3VsZCBiZSBkaXNhYmxlZCBieSB0aGUg
QklPUywgYnV0IGlzbid0IGFsd2F5cyAqLw0KPiA+ICsJaWYgKGMtPng4NiA9PSAxNSAmJiB0aGlz
X2NwdV9yZWFkKG1jZV9udW1fYmFua3MpID4gNCkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogZGlz
YWJsZSBHQVJUIFRCTCB3YWxrIGVycm9yIHJlcG9ydGluZywgd2hpY2gNCj4gPiArCQkgKiB0cmlw
cyBvZmYgaW5jb3JyZWN0bHkgd2l0aCB0aGUgSU9NTVUgJiAzd2FyZQ0KPiA+ICsJCSAqICYgQ2Vy
YmVydXM6DQo+ID4gKwkJICovDQo+ID4gKwkJY2xlYXJfYml0KDEwLCAodW5zaWduZWQgbG9uZyAq
KSZtY2VfYmFua3NbNF0uY3RsKTsNCj4gPiArCX0NCj4gDQo+IE5ld2xpbmUgaGVyZSBwbGVhc2Uu
DQoNCk9LLiANCldpbGwgdXBkYXRlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KPiA+ICsJaWYgKGMt
Png4NiA8IDB4MTEgJiYgY2ZnLT5ib290bG9nIDwgMCkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICog
TG90cyBvZiBicm9rZW4gQklPUyBhcm91bmQgdGhhdCBkb24ndCBjbGVhciB0aGVtDQo+ID4gKwkJ
ICogYnkgZGVmYXVsdCBhbmQgbGVhdmUgY3JhcCBpbiB0aGVyZS4gRG9uJ3QgbG9nOg0KPiA+ICsJ
CSAqLw0KPiA+ICsJCWNmZy0+Ym9vdGxvZyA9IDA7DQo+ID4gKwl9DQo+IA0KPiBBbmQgaGVyZS4N
Cg0KQW5kIHdpbGwgdXBkYXRlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KPiBbLi4uXQ0KDQo+ID4g
K3N0YXRpYyB2b2lkIGFwcGx5X3F1aXJrc19pbnRlbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpIHsN
Cj4gPiArCXN0cnVjdCBtY2VfYmFuayAqbWNlX2JhbmtzID0gdGhpc19jcHVfcHRyKG1jZV9iYW5r
c19hcnJheSk7DQo+ID4gKwlzdHJ1Y3QgbWNhX2NvbmZpZyAqY2ZnID0gJm1jYV9jZmc7DQo+IA0K
PiBJcyB0aGVyZSBhIGJlbmVmaXQgdG8gdGhpcyBwb2ludGVyPyBXZSB1c2UgbWNhX2NmZy5GSUVM
RCBpbiBtb3N0IG90aGVyIHBsYWNlcy4NCg0KVGhpcyBjb3VsZCBtYWtlIHRoZSBkaWZmIHNtYWxs
ZXIgZm9yIGVhc2llciByZXZpZXcsIGFuZCBJIGFsc28gYmVsaWV2ZSB0aGF0IGZld2VyIGRpcmVj
dA0KdXNlcyBvZiBnbG9iYWwgdmFyaWFibGVzIGluIGZ1bmN0aW9ucyBhcmUgYmV0dGVyLiBBZGRp
dGlvbmFsbHksIHRoZXJlIGFyZSBtdWx0aXBsZSB1c2VzIG9mDQonbWNhX2NmZycgaW4gdGhlIGZ1
bmN0aW9uLCB0aGUgbG9jYWwgdmFyaWFibGUgJ2NmZycgaXMgc2hvcnRlciBhbmQgbW9yZSBjb252
ZW5pZW50IHRvIHVzZS4NCg0KWyBDZXJ0YWlubHksIGlmIHRoZSBnbG9iYWwgdmFyaWFibGUgJ21j
YV9jZmcnIGlzIG9ubHkgdXNlZCBvbmNlIGluIHRoZSBmdW5jdGlvbiwgZGlyZWN0bHkNCiAgdXNp
bmcgaXQgbWlnaHQgYmUgbW9yZSBjb252ZW5pZW50LiBdDQoNCkp1c3QgZnJvbSBteSBwZXJzcGVj
dGl2ZSwgbm8gc3Ryb25nIHByZWZlcmVuY2UuIPCfmIoNCg0KLVFpdXh1DQo=

