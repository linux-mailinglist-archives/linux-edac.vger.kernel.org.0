Return-Path: <linux-edac+bounces-4021-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC4AC6E1C
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05207AD6F4
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DB28C5D9;
	Wed, 28 May 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj7xDd05"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877B28C859
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450233; cv=fail; b=Mzi2b4wF3gHG81UxpMvZSGfT+5hyhX0AVls9PYg46yqNH9FWeB40lZBAPrivvaEG6SrYyxcQXSksLXnkOOVVPAm4iTaf55hIOiopi8CgeCQKF86KXMLfyGcb92cyzHoBcs1P1Y1iZ+/lnEk2CfePuMfIgElW/HL+oqD0P6aJkDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450233; c=relaxed/simple;
	bh=fB/oOzCKwYJGt29XYHLu6TgNMASBOgy6+/i2ryH9Hk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFNJyzxRgUZwru+OEK0wJQnvKy2ukhLFX5455qDe0NQriIRYoHxCKKQElc+O8FydORbqeb0iSnHfLGFIY5MCE2Mw9DaT+91OJR595/wdCvg8D/8HcZEgTRX8TYl4/Tq54jEqFNy51ozP2RIG9fVYK3zwtroz7K/rOivMWD3cNMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dj7xDd05; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748450231; x=1779986231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fB/oOzCKwYJGt29XYHLu6TgNMASBOgy6+/i2ryH9Hk0=;
  b=dj7xDd05b/2UiuHTYm7dvFFZjWSq/7/gM7FKJdPlGaKyEgfX8P/JqoFX
   ZnMk0BGpdBZqVQVCwAuQhKjvvxM9CCLU6WSyBHjiAaGVZ2k9ZA4Bosrix
   jOjVxFJKcLXRPTleRI7MzKreDFCjnbHQDYFagL0rG2EynqIDzYaZqjHyh
   1XC/S66quIwyRsWRqaFcsL/3C1hytE6GGYWojLJsIXHwDR2jGP+JmhpUK
   XoRx4+3f+D4ExyDcVpCL/mZ9Ec/xddh1zuijl4MiOGweoQGeUSPBz5m10
   YcDbN0TuG37GjK8BBaQH4XHC21RHTYWqhp9sLq6Z714LJFMRpno6XNiCF
   g==;
X-CSE-ConnectionGUID: qZ0VpP/SSruMKZmOXcorVw==
X-CSE-MsgGUID: EiNa47uBT66rsLcOgiW+6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54282360"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="54282360"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 09:37:07 -0700
X-CSE-ConnectionGUID: y5xupbpkQraEecb5zUQfRA==
X-CSE-MsgGUID: +wz8t15PTfOqXqrFUsfFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="147172615"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 09:37:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 09:37:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 09:37:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.83)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 09:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maa7F8FAXBbADLQyACkyw6Rwu9KEieTVTbjPI507cpyu7rbsQ9pwYsVX425Gdoh7cILAeA2dd4x62i/SIkz2pSx0dpzNXWMmqDXFEJNtVlLbZTy/mtCZmhHJZ8ASQ0Ubc9NBBdljSNpDuLCNlDwhlHggRY0FmL1yJ6KQp4IFjV0LmnGw49+UXTm8ho7r1h2ZVS1agxoSpxHb8BwICmbj21apgs/YoW/lC5F7mWr/P6T6Bac0f3G/MIfdHYy+PKkBG2ORIQb5gB0fMSjlguDYwrVn0kYxua+wMHw4WK7RYOkWSMoS4b/kZ8ImeHYQMwWDpAtrWTkO7ssclf/XX3n53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB/oOzCKwYJGt29XYHLu6TgNMASBOgy6+/i2ryH9Hk0=;
 b=zUY/UkzLBm3MvXpsuqATqQVTlHmUAfdNYFiT8KoDxP4Hm+KBvpXe9G1Sp8ZEK0Q1NZdtSdc+xHei0hjUZg9X+yeiIdQYBiA8UznT8IW8IdFxWWYodjYdYxYW3b5WFX0tUtz8L97Z3ydmkISW0xDNUnataVTsUfZcMKktmKblZVdANEiXYHwefUDizfG4GS4d6/DHrKzKqFUmqe6uJ/WFifxcchUP+I6alsLF/bRUBc3USaGvAv9rXBJzG8j4flxOP4iN2CD9NnsWJ1fdk9uRbhX0Q1bBixXcpMts9o41s6OOf9YIZ01D3cDB8ab2F9nOIykzmXRBbFkGLrZRk5HVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 16:37:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 16:37:03 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: James Blake <jamesedblake@protonmail.ch>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: amd64_edac fails to detect DIMM with only one ECC UDIMM installed
 (works with two)
Thread-Topic: amd64_edac fails to detect DIMM with only one ECC UDIMM
 installed (works with two)
Thread-Index: AQHbz+twPAZAk0cMjUyD2E3jsh2HaLPoPCwQ
Date: Wed, 28 May 2025 16:37:03 +0000
Message-ID: <SJ1PR11MB6083E9F562FBDF110549B33AFC67A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
In-Reply-To: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7582:EE_
x-ms-office365-filtering-correlation-id: a8dfa56c-3832-4e4e-c3b0-08dd9e05e078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TExhOVNzd1FBdVNkd1BYa3UxTjVFSW9waG1zdDVLaXpCbDUrcXJkcEVVbStP?=
 =?utf-8?B?MnozS1dqcHV5OThHRTF2L1Q4UG81a1IxWlpoQ1Qvam12aEdyU2VmRnVKaWRr?=
 =?utf-8?B?ZXJ0dCs0NTFybVhibEpVRlc4bDZ0UnNudHM2MUxYT2pVVEJPVSs3dUlIcDBL?=
 =?utf-8?B?L2NwNzRWZGppYVVHUCtvN1Z1dXdVS2NRck1GV1F6Yk5aZFlydCtTZERCQUtk?=
 =?utf-8?B?VmFDSk5VazJLakl0NnlQeDhLdmlVeUUxWnNmVGIwZ2xDdWtXNlNFdXVMT1Nq?=
 =?utf-8?B?Q2xMVHFJUnd1TE1RVDdnakczTE5iZXpOVUxPN0xrRDIrQUN1dW5OUTZqT1Yr?=
 =?utf-8?B?Z1pyYS9YR1VndVdhVi9jcER3NEhZaG9GK0MzWlRCS0x3SWliN3ltZnN4a3hl?=
 =?utf-8?B?NEkrNytHSE1mUFVOc2hybGxzdG55aUtkN2d2ZkVJdGNzQUZIdlFoaGVTRFNu?=
 =?utf-8?B?L0hKTjhoeDB5MFVXbkNOUWxmL09QeE4ybTlsc1dHeitrRU1kL0ZORVFFbXJu?=
 =?utf-8?B?SUF3RENKaGVUZ3JrVTkvR1RkUFJtR0phYnFhaE5JY2hkTUhSUFB4T0N6dEdW?=
 =?utf-8?B?MHIyYW00NmJnS05Mb082bncrKzFuRUhpNjY1TGtRTU9DaU05UkNsME1IU3F4?=
 =?utf-8?B?MXNuQlkzckdmT2t1c2dCOHNuK0t4d1QxalBvRVNxbytvNlhqNGRmWW5hOVVT?=
 =?utf-8?B?WExUQUhRSnE2Rk92TW5kZFVoOGoyZU1MdUZDSDJyMHBRNFpGd0NIU0ZrSUdy?=
 =?utf-8?B?LzJoM1hzaE9vNUZ3NGJiUHptTlVoRURpMTV6YkcxeEZaY0ZmeDhLUTF1YnVU?=
 =?utf-8?B?NkxlK04yaTRYdy9uMzkveDFkV3hqVVV2K3dMK1RQRUxmekxvK3EvMU5wZmc5?=
 =?utf-8?B?RnpIbDNqQ0JDUkQ3dFRWWlQ2ZWpRSmkrT0M3TlZVZDJkRUkwZm9EbXdGMzl5?=
 =?utf-8?B?VlRIMm44NDFOK0NGYllBbGM3bU43TVAreFNJYnJyN1kzZS9wNGkrbFl3cmIz?=
 =?utf-8?B?MUZYZGhhMUFPT2MybEFmeTFWY24wS2RUb0srSnQrVHM3K0lkcEs3aWsrbjZm?=
 =?utf-8?B?TCs5Q3MzeFEzYm9Iem4xcjJWWFlucmhJdnhtUDQ3cjBPdVFJWEJvZ0xXRVNJ?=
 =?utf-8?B?NExLangvN0NEaE9JTW9jOUFadzlsUVQ2S2U1MnpaQ0lOTnplL3E5NkVuRHdj?=
 =?utf-8?B?Mm1jL0JBM1Z4Vno1ZHBra3pGLy8zZVd0UTNtY1FIV3lGNXYveXRSd1FLb1BO?=
 =?utf-8?B?NnVYVWNaQVRiam96Smp6a01YZ1R1NnZrWjZSNEtSdmxPVmhzZ1VqRnp1bkJk?=
 =?utf-8?B?Q0xxbmlaYTlOWmpYNmxudENqK1VTangxcnowL3NUalFRM2FBbFRMZ3Z3UXlS?=
 =?utf-8?B?OGhma051ajJxV0dZS3JCazZxbHgwZ3FaVTdFdXBnTlMrS0pudEY2MlR6N01F?=
 =?utf-8?B?eGpjS0swREpzM2t0d0tzOEk0eXg1YzJMY1ZwTFkzT2RpSW54aFlrL2tncnBr?=
 =?utf-8?B?RFQ3TFo1Mnc5dkU5bEU1S1lNL0dudjB4SnhXZjFTTnVscWZuVGQ1Z3FpeEcy?=
 =?utf-8?B?Ui8vTm9RNFZpTjA0ekRMUnpHMHljanlrRjRWMHhWZ3htTlBvV3BGNDlNcUhu?=
 =?utf-8?B?SllTVTVod1k4MTEyKzdZcVdvNG93OU5JK0E0MlNsMlJMeFRYNzBLTlRLZEFi?=
 =?utf-8?B?d2RQUGRoTXdjNXlGV1ZKTmlVMTZ0MmdKb0xoNUk0NGNuZ0ozTE41T3JOVGFR?=
 =?utf-8?B?WGFGNU5NakVpaUx1ZnB3cEUyS2p3MTBiVDBTcVVHQm9ka085YWc1c0lCa3dC?=
 =?utf-8?B?R3ZLc2hyUzhVUk9pMTRRbkwzMStnVTdTVjZ2aHBSOElVdFlJTTJIVXJSYXRY?=
 =?utf-8?B?dy9IWWo3MkMweTU4bXhkelh0YTY5SmcyRGhORytocW1FRURCL2g0NHIvbGoz?=
 =?utf-8?B?K3JmVjVaQWZIdll0L1lqUCtZRUJweW15YkY1N0xxdjdjZG4rOUlHRDJZckF1?=
 =?utf-8?B?QlFmZmlCNG1nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akQ0anNRM0ZHbC80Z1B3UERSSDFHOEZDS281VnY2SXRENE1zL3p4dVhpZ1BR?=
 =?utf-8?B?NlZ4eWFsZzJOQnl6Q2ZrdGorYkFEbHVRelJCZEdtSW9DODdSbVY1V3R6eXBu?=
 =?utf-8?B?QWRmSEQxdkF3Qjg2NFkyZTFXRXV2SU10LzJCM1JNb0dvVFJwcHFFK2g4YzNo?=
 =?utf-8?B?Qkt1NnkzOGppSGNtelBHTG5HVkcyVG5FUDlpQmQrckM3N3pVcE03a3BGQU4y?=
 =?utf-8?B?YjljSk5nWWJzak9BbTlBQng2RFZ5ZUtBWW1zZCt4MlJndy9PakdQVEpqdCsr?=
 =?utf-8?B?NXcyRGl2NjI1eHJuSm1aVEJCUi9ScWdTQlpOcU1YbVFrSUVwZTdMei9FS0Ft?=
 =?utf-8?B?c3krSzBleWxJYldMdmpFMFlkT2pxeWlQT3JOekQyRFd0YkVxbFVIK0pyYU9M?=
 =?utf-8?B?YzBHWGduT1ZoS2lQdDdMKzY3VnFlLyt3N3h0d2V1ZzhjUjRZQzFWL1RmcDdS?=
 =?utf-8?B?dVRYWXlSbCtkQ2xFb1ROdWR6UTVOVjZhMWlBdWdMMDZ0MkpObWRvU1JDSnFK?=
 =?utf-8?B?em9MWTdGVElwamFlVEN4NTZIRDVlT2k3RURtZmtOVDdzV2dUYyswNFVnVEF0?=
 =?utf-8?B?K1JkTWRaWjAxZzN3eVBOUlpEZ2xmQlpHeHl3ZTV1Uk04VGo2Yk1ZQThCZkJ6?=
 =?utf-8?B?Vkk5aVdQYUxmQ1RSNnBoeFRJZ2c0eFphWVVqd1k1c3U3M2JwZ2xjWWc4dThF?=
 =?utf-8?B?NENUVlZQVjdwV0Q4V3ltVzNQRVNPZUxtVHBDaFhHcFdaTnFqc1c5UmMxaW5x?=
 =?utf-8?B?YWZKWVg1ZWhXaWxhRURaRUJObStPK2ZNM3VCM1llNlhZQWJRNTlJUURtM2c0?=
 =?utf-8?B?WWIzVko1OW4xT3dFWFFHaktiSmRwNXh0Nm8rRmp1ZFoyQlpyQnVqTjdDeTNv?=
 =?utf-8?B?cm1RTGpUSVVKS2RUTDBmVjgrak1EQmtJeVRhazJCOEs5eUVQRWVEQlY1QWhB?=
 =?utf-8?B?MExGVGhlNDJnOUNKYVgvV1U2UWFOTnh3T0lWNzRnNHF3TTFSM1lwNWdUTnZw?=
 =?utf-8?B?YWpMdlhhQjZDSnp0cm9TOUtocW1sbStYWlpBS0RkMUUxOFlVOTAvNEsrUUdT?=
 =?utf-8?B?aWV2WDlVQUVPbW92RHZuY3dObERncSs0ZzVJSk1SUWhXdzRJaFBmalFoUzZn?=
 =?utf-8?B?NnpkUzNWb3pXOGNPaUFiaTA0VXQ0MlJzVXRiYXVta3FDWCt5dU1iWk1RWGZG?=
 =?utf-8?B?TDZHTHR4KzB3UitvWkxjVkQzQjJZZjBCTktlTHh0c2thL3ROUUd6NmhvaWpE?=
 =?utf-8?B?ZHF1czRRWXNiZDIrRlI2UnJjWndrMVZ0YnNwaHN6aTJKeExBYm5PY1Bua0FI?=
 =?utf-8?B?T08rcDYxYk0rK3hvWHFDVVV3R2ZNODI4elBrNmltRTNDcmJMTm9WanFZVUxE?=
 =?utf-8?B?MEJoWGpQVDRRekRGNTFWWHJ3eXEzc0JFNkM5cmtPenNUTTJZaHdkZUNSTUpN?=
 =?utf-8?B?Z0NreW5EcXIwQkEraFpIQjRla2N4SG95ek9GTFdOaWZGZkZUSXV0dUdTejE5?=
 =?utf-8?B?citnaWhQbTVxRVgyVW1TSm4xYVVyMkxPcElIcmRuWW13WWMybjZhVG1Bckdk?=
 =?utf-8?B?UWhRVm54NmdhRFY4ZjJQUVBqOXJlSys4bVJDODhYZnljUzM1N25MQWg0NFdl?=
 =?utf-8?B?b0VQQzB5c1l6VktkbngwRy9kcUhwdGpqWERVeUw2WC9TWHlwYlplWXlEVW8r?=
 =?utf-8?B?ckJPZTVEWW12OVBmZStESERTbTNNTzdTU2RRQUU5Vi83akl0OGtCOGhrYmlR?=
 =?utf-8?B?VXpkbkI0bC9xekpyQkxOQlltalcyaC9HeVE5ek80akFwc2FiQngrcjFXci9s?=
 =?utf-8?B?aE5UUDJkRTZOMFhTcVZaTFlsZGx6VVk3QUhLVmovV3lHZkhiZWZKSFAvbVNL?=
 =?utf-8?B?REVMZHJPVHZsU3hNYjJxTU5YWnk5cDN1d25Bc1E0QXBuYStEYXRJMEdnVGp5?=
 =?utf-8?B?Y25YMEQrNTRLcGtZQ2FRTWNlKzBNZWJTR3RJNmdNUTJRVnN6VmdxWnUxSk43?=
 =?utf-8?B?dFRybEROK0haRmRLOXI5bDJFNFlqUFBsMEVMZU9BcHRpSzBSQXdCOGc3VURz?=
 =?utf-8?B?YzYxT2tFTU8zd2NHUGhEYlNaMnhDdzE3WGdGemFhYUNQMjJxakphVkVmZWtr?=
 =?utf-8?Q?jR6j7N5HVKQOA6RB5+4katrgK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dfa56c-3832-4e4e-c3b0-08dd9e05e078
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:37:03.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sC5LBr7oudyETFAShn52YfAvdkQ1N9r2LH33wm7pdRy+Y1uMpWAmPQwpmQsZw3g8smd77jd6RX4xEj2eRMG9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com

PiBXaGVuIGEgc2luZ2xlIEVDQyBESU1NIGlzIGluc3RhbGxlZCwgdGhlIGRyaXZlciBmYWlscyB0
byBkZXRlY3QgaXQgYW5kDQo+IHJlcG9ydHM6DQo+DQo+ICAgICBFREFDIGFtZDY0OiBOb2RlIDA6
IE5vIERJTU1zIGRldGVjdGVkLg0KPg0KPiBIb3dldmVyLCB3aXRoIHR3byBFQ0MgRElNTXMgaW5z
dGFsbGVkLCBldmVyeXRoaW5nIHdvcmtzIGFzIGV4cGVjdGVkIC0NCj4gRURBQyBkZXRlY3RzIHRo
ZSBESU1NcyBjb3JyZWN0bHkuDQoNCllvdXIgZG1pZGVjb2RlIHNob3dzIHRoZSBvbmUgRElNTSBp
biAod2hhdCBhcHBlYXJzIHRvIGJlKSB0aGUgc2Vjb25kDQpzbG90IGZvciBhIGNoYW5uZWwgKCJE
SU1NIDEiIHJhdGhlciB0aGFuICJESU1NIDAiKS4NCg0KCUxvY2F0b3I6IERJTU0gMQ0KCUJhbmsg
TG9jYXRvcjogUDAgQ0hBTk5FTCBCDQoNCk1heWJlIHRoZSBBTUQgRURBQyBkcml2ZXIgbG9va3Mg
YW5kIHNlZXMgdGhhdCB0aGUgZmlyc3Qgc2xvdCBpcyBlbXB0eQ0KYW5kIGp1c3Qgc3RvcHM/DQoN
Ckxpa2V3aXNlLCBpdCBtYXkgaGF2ZSBzdG9wcGVkIGxvb2tpbmcgd2hlbiBpdCBzYXcgdGhhdCAi
Q0hBTk5FTCBBIg0KaGFkIG5vIERJTU1zLg0KDQotVG9ueQ0K

