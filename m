Return-Path: <linux-edac+bounces-1881-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6909897A550
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 17:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66722B20DEE
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2AA15990E;
	Mon, 16 Sep 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTksG0Rj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0215A86A
	for <linux-edac@vger.kernel.org>; Mon, 16 Sep 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500502; cv=fail; b=nw+eVGjgyywhZaN8MVoJW2KAgNDoburXqh9b1414rzPeraaVOoI75wi97rVE4UFFDax8/ADRSHjq7kRZ7x7Ozb1V6mjq3aud7khC9rXcbU89JnX2jx5Co2M7maF1JsIkXtoHxO9Qt3u7OVuJ510hru16Qlf91zldOKr4SOSydw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500502; c=relaxed/simple;
	bh=7Fa/AB4askwDtp97twGVbXRHhGW2V2Z5IvyI8Pk+f4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNgZUFBNZl2HWMM7mRehehQfiFr92jyE1ym9Cm8b3XicsJ6tRPH4wecrxORdQLzJmAUHtPODp0YdV9TOEoOs4FsgsHJRi/RBgPso3jkitVEp7yIut7Uxs8PockvMS8Blm7T6ZS4mQkL6whl1vTE8lcJ+tJraPE3oAogu4mH3DGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTksG0Rj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726500501; x=1758036501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Fa/AB4askwDtp97twGVbXRHhGW2V2Z5IvyI8Pk+f4g=;
  b=PTksG0Rjfcdv2f5TO3Wy0LVmXmAu5+gYMuXNgvPeJpcufl3iBrx8Fsk7
   9E1HLajgvuWU5leq31P2NFcrISmgV4aXlnRNkpGW77/HmEEeRGapbO/SG
   Rcp/bHDncr2+6OfJL+Z5YJwGwp435eX5eb+t0PjizxyKJG2JTW44ZED9U
   ka0lR/lmp5GLqcvCIodDWbFdYO/3yJJNBouDZ3ySqCBmh530+698nWVST
   r2gj6jZ25M8I/3WjdLxyNYkgbF+X6/b/UHjY7bWQm89x9V9dWeDl1wnAq
   KloG2hsiCfbJMDxhwRXLmJBWuNUWgFYYe84woaVfA7y32MP8GLpTPzSn9
   A==;
X-CSE-ConnectionGUID: gwlEZOt7TXmkDIsXDzn7uA==
X-CSE-MsgGUID: 3rJ2ieg8TnCUf85ren03pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="24812472"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="24812472"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 08:28:20 -0700
X-CSE-ConnectionGUID: 6xf0CLZ3QbaqyaRyBmpKNw==
X-CSE-MsgGUID: fxKaVujnT0G2eZDLF09/yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="73729510"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 08:28:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 08:28:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 08:28:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 08:28:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 08:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI4TkBN1u9OICf3swgfPzD1Z9/Mf6aZqkfjCzuq6iLfUEorpcCLHQp66EltdjHbtqp2wrFaImnpDLLW1JJfQJ8J5N4g4E80AcSebaNqfO3Z07VQiHc2ESqs//Inmo3RPPIagOWpsuDGyBO8fpNbvXTrYWYuurxc4GqYXQ6nERIlW9ZxTvZC/hgyiOYfXqq0gbfoM5++Nw7efmUv2RIsGsyQ6j42+Eq/OwR+VOJWWR+J4KFwX7hfzmco96fRWqY5x0beegy8jCM9ZqD0BwtNdgBSRDxoHvNwsNXyW0vszaKKI8fPxtAuW7KE4PqDSfkRPt8Wsgwu3U08zTJN27iUmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fa/AB4askwDtp97twGVbXRHhGW2V2Z5IvyI8Pk+f4g=;
 b=Ui0IKnK0DHxthIWk1lQeT9+TCsLFf/Ds/KWjmx9Vkf+RoqinRldYU64wis72cpWbiT6flSaKE9WG9tMiuEehiEtMNS1L9jn3U0C2gvUE6hJgmt2y/b9UTdWkH1u15OGaJG5FoLKT6doMogPe5/ruVdRNfHMOgldW/MQbkNpkAjzdOygc7438kZMngy/cHBTKuIKW+JJFZ/PcxDoHFS4JnroJnjCnVJBQ9hjSPC17QbX70qBp5eyBMYpH2wBfvwv/NC+pmwEoWUbWE8Pl6gnYSu1z+uKzB4uJVDWHZdibVKV10PPktzON+6BeZqY464R2sMgLhqNSyqEaZ1pv27I1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 SA1PR11MB6661.namprd11.prod.outlook.com (2603:10b6:806:255::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 15:28:16 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:28:16 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Askar Safin <safinaskar@zohomail.com>
CC: linux-edac <linux-edac@vger.kernel.org>
Subject: RE: Is it true that uncorrectable ECC errors always crash the system?
 (I want this) It seems my system is unsupported in edac
Thread-Topic: Is it true that uncorrectable ECC errors always crash the
 system? (I want this) It seems my system is unsupported in edac
Thread-Index: AQHbBf0IfsDjaOehJkunsM6C1cGjurJV8HdwgAFBa4CAA1lW4A==
Date: Mon, 16 Sep 2024 15:28:16 +0000
Message-ID: <DS7PR11MB6077B88862D8231BA82F3828FC602@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <191ec4abfe4.ee5cf21f77536.5289498031536692169@zohomail.com>
 <SJ1PR11MB60836E226A36DD482E284796FC652@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <191f0700e16.e4ac896383888.3692757560429165043@zohomail.com>
In-Reply-To: <191f0700e16.e4ac896383888.3692757560429165043@zohomail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|SA1PR11MB6661:EE_
x-ms-office365-filtering-correlation-id: a28e2653-5120-4e3b-ebc2-08dcd6642fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWF4WXArbDZEVUpvdGhVSEVOUHMvNzVUUFdEWEJIa2FJays4aHdzYmtrZzdK?=
 =?utf-8?B?ZXB2MXFSUGpJTnNwYTAvcnYrUEdFaFFzeFE2N3NvK0JGTzBvVlNtN1JIdVJt?=
 =?utf-8?B?WFFqcjB2Y2VWdno5OTVrc1JaVzE5c1BNQTd6M2k4UStRYVUrTW5Iby9lcUpr?=
 =?utf-8?B?Z2c2ak5CSDNmdHpCcUJhYkpRbEd0OXBBQkhZSFpDVHpYWkZPTm9HZ0RkNXoy?=
 =?utf-8?B?S1pJem9Fa1FyUnJ3ZjMrNWhtM3lIODA5Y3d0c3k3WENKdkhvbEJyWkxRVlE3?=
 =?utf-8?B?WFJ1YTVqUlVQYlI5cWlBVFdqbUhFckJabllPOTBPWVNIRy9ZZjlCN1RrSTFr?=
 =?utf-8?B?dG1aSGt5cFQwanlTQ21Bdm5pNWZ5aGEyR0R1c1BLeDhQWEJXU0Z4M0hJVDVH?=
 =?utf-8?B?NXp6dkpOYjhJaGl6bkFGUkNTKzUwckh2bWx1ejlPTnU5TVRCSUF2dndMbURz?=
 =?utf-8?B?TTNPU2REWTRBV2R4YUtOck1DYVVTL01rc0FUSXR3SVBRdGpKV0FRUGE5eExr?=
 =?utf-8?B?TWlkYlBUWVI3QW5ISlc1d0w4OW1zZTdrMUQ1b2J6eDZZekVxaTBYdXJ3NERV?=
 =?utf-8?B?ZUxoYXhTVytncmxLVzI3cTkyanlxdmdJYnEzbnBvajh2eC9NdFNSM3dKYmVo?=
 =?utf-8?B?UmRXZHNuK1QwanZtOE1MbVJJSTIrUTBITFNNQXJ5Wlc3NlY4T3VKdWlJWUph?=
 =?utf-8?B?eG44M2c3NlJxcmFXbHZ4NjVLSk9FK1VTUXlGZXJMVU5sdUNRQXFBUkJOQlpt?=
 =?utf-8?B?c0JJSjVsQ0RtNGlrRnREMkNwajF2TlVHaFozQi9wU0dGM082YjRoRy9pckll?=
 =?utf-8?B?R3ExbENPVlh0UnQyazA2OURpQ0J4QzBIcW16U1lNT2xLcXNxZFYrNUJFS3Fm?=
 =?utf-8?B?K2VXVG5hbUxmR21oTGV5QTVxSGFqSXVHSGcvb0kxajJhay85dUc0VUJ0T0U4?=
 =?utf-8?B?NUhzUE1nLzJtWFJjcnlxbVVLU296OHhYWW16SnQ0VjFtQ3dHMUVTQjdQcXRi?=
 =?utf-8?B?a3N2RUxSYlpUYlpPZEJZL3ZzTmFRMHpLZWRIVWN5T3VSZ3N4UHhWeWs5M0t1?=
 =?utf-8?B?Q3ljQkx5MDYrdUFWdU1HaVJvRDNOTUtmS3d4SXdKY21RajNmMGpRVkRlQmh0?=
 =?utf-8?B?YXRCQ01wSFVwM0pmOFlQS3oxOW5tbFVmaG91eXI3eDFFcjlPamhJWlUrT0F5?=
 =?utf-8?B?M1N4UTh4aEFYS2IyaU9Ud2JPWnNtNjBvQTN1cERUb3c1RGN5RzU0emVlM3pG?=
 =?utf-8?B?WTFEWDRKKzYzbzh6YythOVAzdHNIcVkwanZ2ZEJRY2Jsbm1nOXdNQVp0a1N4?=
 =?utf-8?B?ZUxYTEUrWkk4T2RzdEFqV256dUpMdmJHUmZHSVdoNUUrejVReWluSlRpNS8x?=
 =?utf-8?B?WjhYcVVKMkFaVGxZdlJIelg2VUdqNDhCa0VmVjBQdys2SW5FRS9sTk1yTytu?=
 =?utf-8?B?MDhhZXBKZVBFZ2xIYU0wMVhIN09nY054bW1LL2txRmtWMVo5VmtaSXZ1N2Zj?=
 =?utf-8?B?OUp0K2ZXODF3dW9NaWQzeStEaFBXdzQzQUJqWGFJVHVjWjlXZlZxNzlEZGJm?=
 =?utf-8?B?UlFSeXV4RGd2S3JHMGNON3V4V21lV3VxT0YvVzhaeXRZUGRoWG0wbXVhYU9P?=
 =?utf-8?B?NVdSNDRsam9EUUJCemgzTHM5UUljV24rN3JhWWM2aVVwQWd0bnRwQmVsdU5R?=
 =?utf-8?B?WW9Kb3grU0dQN2RLd1ZYSlpmdFlVNmFzRVRQVFo0a2hVZ3pONDJnUXJtbllQ?=
 =?utf-8?B?NmN3c3d0b0NDSjl2SWhIMHBZOGl4MmtFMTU2bnE5NEtrNmZEUnZsOWsyTFlw?=
 =?utf-8?B?ak83YU10TkIrT1NsNUwzODZGeWhiWWJFbi9KNDc1MFIxaTlvd0t1Zm1zVHVU?=
 =?utf-8?B?NnFtT2xCMTNwR2pXbmZmbXJJUUd0eHFXeGp0SjNhY29NMGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWZCeXVWNnZJTlN0NnZ5amdaS3Nwa3VwNC9UczlKOVN5QlE0QVFLeUdvM29U?=
 =?utf-8?B?aUszVjArSTBPU3FEN05kY0tqK3Bvak9uMEhud1VMYTVvL0NjYW5rNW1YdmMr?=
 =?utf-8?B?cE1qd2FkQWR5aUk1eXVLRHl1c3dna2ZoNVFJQmpFSzJmUm1tWlFYaHNocDI3?=
 =?utf-8?B?N2tHVis0YmtvRjVBTDNTNkQ5aVVHS1RVVXh1bUMrOG1EMFluTTdqVUFzQUxD?=
 =?utf-8?B?S3cva2hjdDZFREVocWd1VmtuUTZaRlVVUkxuT0R4VXFXWU45Z09zTGRtbStF?=
 =?utf-8?B?VElzMDdnYVpPZUh2NmIwSVVmdUR4R0dOclRPdDdXQnBRZFhBS2Z3bHVJOTFl?=
 =?utf-8?B?NjNJNjVTSzdUMmpoNWtQU1V5WWNKcE5FUW5welVJemNXZWw3eDREcXE4Nktu?=
 =?utf-8?B?Vm9EQXBWSytYdTdXaUE4VEFLL0hFa1h0SlhyWEt5Wmt5RmRTdFJ0dDhjNEJN?=
 =?utf-8?B?eW1abkUyRDUzNEtMYW9xVjUrSmR1NkhiWFRPZGNXM2RzVGU2U2JsT0Q2aXhW?=
 =?utf-8?B?MHNhMGhtdzFqRTlOcjkxVWdOUllCRjVyeWY1d2JMV0VIRDU5d050YlVleFZX?=
 =?utf-8?B?SWdLeDlDUkVpblRvaFFrdGM0WXJjZDd5SCtJSWpTcmFxTWlqT2kxK2phMXdm?=
 =?utf-8?B?cHpFSGh3dlpncUlFc2xSZnVnVHh3cFpxQnp4eWV6UjMzQjRGZnh3V3lzQVN1?=
 =?utf-8?B?clQ5bmtCazF4Q1k5ZjMwNEJnalNmNjNIZnRTdmhNWkFLdElHdlVJNzZRc0Nl?=
 =?utf-8?B?UDdOYVlPODVDaFh6RWpma0ZMZ0hJRkJZbTNpZ2ZicHcrVkRXSUdMMVFTK0Z6?=
 =?utf-8?B?OXJmZmRQcVd1YmIyMFNpNzJIQjVITks2R29jSERQL2pqTXhKQzRuNzlUZGJa?=
 =?utf-8?B?UjFLL3BQQW5IQm85WXNCRGVNRDhPeHd3V29ZRnpTaW14dngrbEV5TFpwTUhm?=
 =?utf-8?B?d1p1bTA5TEhYRWlhTkdSK0VKcllITC82U1MxUGY5VTZoQTB2Vzg2R2k1Z2ND?=
 =?utf-8?B?NEJSMnZmbzczdVVqZXo4MUdTRUpKL3ZhZVRlTFFEWis3b0JMdDBKUCtUaStB?=
 =?utf-8?B?WDlMejhiaDVkeW5pQzc3cGRVbTBlc0pxTjJscGJlSGlsKzJRWVYybU9WZVc5?=
 =?utf-8?B?T01vM3ZZUUNmb3ZXaTNiQmp2bTA2bkYyWmdNUk1RVTRCNDdZNy83SndGajV2?=
 =?utf-8?B?VHI4RFEvNWFLRWdyMGlEdWlVQ3FYYlFIbU9QaTA3ZU1naGN3T1NqTWF0TkNY?=
 =?utf-8?B?OVovc2ZpZGw3M1RWbmFZWG9lYVo0b2crOUprN2xGNGJHMEpBeEk4T3JLQlY4?=
 =?utf-8?B?QVd1bzhJVHJadU1hSHBEQTFZVkRYbDhEWWVzWG9FUzBOUCs5a3diaEJZbDEx?=
 =?utf-8?B?cmsyM2M2S1JKR3JrN2pQb1dXNUE2NEl1VDhhcmNxb1RsM1MxZHAwSDFnZFJJ?=
 =?utf-8?B?OGY2NFdUSHhJR2k4N2s4endSV2JZaVB6Ym9ySzRRUisyZXNsK3cxQWN4S040?=
 =?utf-8?B?NTZiUTR3TmJqKzVoYmVnQzB3MGpGaHkvVnpvalgyTlY0YlR5UnFObG1aU3JI?=
 =?utf-8?B?Q3RvR0xwVDN1OEZPWEtKTklBTjVWZnl1VjJXMTlzWm9KamlkMWJKOHFPTks0?=
 =?utf-8?B?SVdWZ0VZSkV3YmZjWXBtRTJyZkxnbThDNG5OM0s5MExrVFoveGFEQnJIcjlE?=
 =?utf-8?B?MzdkNHZFSGFYcEd3NTNLWXF2QUFxbjMvV1NvUHUvbWhoRUlHMTRWSENTZFZs?=
 =?utf-8?B?c3ZaT2FsQXZuaks1MVI2T1AzWVZJL2ZQcU84UXpQVDFsNi9RUUI1bHVjSjZX?=
 =?utf-8?B?dEJOVFNadGdKZjh0R1FYcmQvcU5CR0V3dTZ0c3IxaDJwM1FOQUpWL2t0bVM3?=
 =?utf-8?B?U3d5Q0V4Z1JtS0Q4dkMrekRLWkJ6WnFqU2dXSkIweGhCWjFlR3h2cTRiSVhv?=
 =?utf-8?B?eXNDWjY5NEpUVXphZVYwSmJTdmNRYW50SEREZGdnajlmeDRFU3drTkpTR1A5?=
 =?utf-8?B?eWs3bkVUM0FYaUtGVmdPMDZVbFdmNjRDWTJ1TG1HZitvOFM2YVJ1Ynl4eEhJ?=
 =?utf-8?B?R290d0EvdFVmdlVLZFhQOW93ampWVVJIbXQ3Vmp2VG0vL21zRHQ3SEthOVZr?=
 =?utf-8?Q?ZkIfnhaXjh8XiT168PJ0Tc2WD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28e2653-5120-4e3b-ebc2-08dcd6642fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 15:28:16.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ743wegKYCR6Uol0cSojS0L9FmlkTsoVdJ7X7Igai9CF8uF29e/+fkHXduPrG2cuWJ0BKlLI4Tcpfvyyy+K1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6661
X-OriginatorOrg: intel.com

Pj4gIlhlb24iIENQVXMgb2Z0ZW4gc3VwcG9ydCByZWNvdmVyeSBmcm9tIHVuY29ycmVjdGVkIG1l
bW9yeSBlcnJvcnMuDQo+DQo+ID8hPyEgSG93IHRoaXMgaXMgcG9zc2libGU/DQoNCldoZW4gYSBY
ZW9uIG1lbW9yeSBjb250cm9sbGVyIGZpbmRzIGFuIHVuY29ycmVjdGFibGUgZXJyb3IgaW4gbWVt
b3J5DQppdCByZXR1cm5zIGRhdGEgdGFnZ2VkIGFzICJwb2lzb24iLiBUaGUgY2FjaGVzIGtlZXAg
dHJhY2sgb2YgdGhpcyBhcyBkYXRhDQptb3ZlcyBhcm91bmQuIFRoZXJlIGFyZSBzZXZlcmFsIG91
dGNvbWVzOg0KDQoxKSBUaGUgZGF0YSB3YXMgc3BlY3VsYXRpdmVseSBmZXRjaGVkIGFuZCBDUFUg
ZG9lc24ndCBjb25zdW1lIGl0LiBBZnRlcg0Kc29tZSB0aW1lIGl0IGlzIGRyb3BwZWQgZnJvbSBj
YWNoZXMgdG8gbWFrZSBzcGFjZSBmb3Igb3RoZXIgZGF0YS4NCg0KMikgVGhlIGRhdGEgd2FzIHNv
bWUgaW5zdHJ1Y3Rpb25zIHRoYXQgd2VyZSBvcmlnaW5hbGx5IGxvYWRlZCBpbnRvIG1lbW9yeQ0K
ZnJvbSB0aGUgIi50ZXh0IiBzZWN0aW9uIG9mIGFuIGV4ZWN1dGFibGUgZmlsZS4gU3VjaCBwYWdl
cyBhcmUgZ2VuZXJhbGx5DQpyZWFkLW9ubHkuIElmIHRoaXMgcG9pc29uIGRhdGEgaXMgY29uc3Vt
ZWQgTGludXggd2lsbCBhbGxvY2F0ZSBhIG5ldyBtZW1vcnkNCnBhZ2UgYW5kIGxvYWQgdGhlIGNv
bnRlbnRzIGZyb20gdGhlIGZpbGUuIFRoZW4gdW5tYXAgdGhlIHBhZ2Ugd2l0aCB0aGUNCnBvaXNv
biBhbmQgbWFwIGluIHRoaXMgbmV3LCBjb3JyZWN0LCBjb3B5LiBJbiB0aGlzIGNhc2UgdGhlIGVy
cm9yIHRydWx5IGlzDQpyZWNvdmVyZWQuDQoNCjMpIFRoZSBkYXRhIHdhcyBpbiBhIHBhZ2UgdGhh
dCBMaW51eCBjYW5ub3QgcmVjb25zdHJ1Y3QuIFRoZSBwcm9jZXNzKGVzKQ0KdGhhdCBtYXAgdGhp
cyBwYWdlIGFyZSBraWxsZWQgKFNJR0JVUykgYnV0IHRoZSByZXN0IG9mIHRoZSBzeXN0ZW0gY2Fu
IGtlZXANCnJ1bm5pbmcuIFNvIExpbnV4IGRpZG4ndCByZWFsbHkgInJlY292ZXIiLCBidXQgaXQg
ZGlkIGxpbWl0IHRoZSBkYW1hZ2UuDQoNCk5vdGUgdGhhdCBwcm9jZXNzZXMgY291bGQgZWxlY3Qg
dG8gc2V0IGEgc2lnbmFsIGhhbmRsZXIgZm9yIHRoZSBTSUdCVVMgYW5kDQphdHRlbXB0IHRoZWly
IG93biByZWNvdmVyIGFjdGlvbnMuIE1heWJlIGp1c3Qgc2h1dHRpbmcgdGhlIGFwcGxpY2F0aW9u
IGRvd24NCmluIGEgY2xlYW4gd2F5IGFuZCByZXN0YXJ0aW5nLg0KDQotVG9ueQ0K

