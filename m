Return-Path: <linux-edac+bounces-4346-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CCFB0205A
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jul 2025 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1732C3A5140
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jul 2025 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266CD2E03EB;
	Fri, 11 Jul 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs4D3CH5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB718E750;
	Fri, 11 Jul 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247482; cv=fail; b=CR0752wn9zjsrB9YwI5g8Z/11rMrIh64o2irpIpKBqxI34xa7u/uwXhWW3EjQNC47KA74PhnUm/RwBR1UqF4ivzeSnsO4H6dyD8pU0904VO+VwUehdDIw8kU8BIAAOZsuhH6X+QKLOOnC6pU5NtWNZ1BXM937EL36Cfwywa2N4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247482; c=relaxed/simple;
	bh=3bg2Iz+IcA2PgnOB/qF6cO4S7jAQzrr4Cao0uHYGnns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eNba42JZby3j9XmaMI2D0SYegi3ZWb3bCDKFm0qwCpspIyDMuf/fBoARjMuWSlM6UAbs5BQNZtZoiqp6Bne3GEL6S8uXDDJP9Yr89Zj19s1QeGYOPmGhuQ5sk6j5gKfX/8vnatdqWszJ+76zpHqhMuaLhqydv/lVAVcT5KSp3Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs4D3CH5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752247481; x=1783783481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3bg2Iz+IcA2PgnOB/qF6cO4S7jAQzrr4Cao0uHYGnns=;
  b=Cs4D3CH51skTdeCv0bcZ5ZIqKobvnP2kJzR0kOO99aP6H8SrniidsBwV
   bdMv1qVfnj0iTNTnsQcKTAuBXZxXRffxSjekSAm4csuVRj0WTW7z74CIU
   v3lDY9pK7EoJOuF7/WCw3fFAWz82dXncGdEEXRku9T48Bb/vkvka867Lw
   QMOwZIXfS+bjtSgkDqeXAlM3V3th0dIUv/qPmQdKvKwM+c5y9H5mNaf0F
   vU1x7+j9QlQ7VthT9jt22BJIov2knORO900nD8XIC5lzLNNpiD/9pDp3S
   MTjpJxTpYCgnCTnHEtEAXlgxSHapgWKpJJ4+Sq2RYjIjmhrPdo5qA3Iee
   w==;
X-CSE-ConnectionGUID: hBBu9O6JRrOGENf1L88qXQ==
X-CSE-MsgGUID: CGylAcISQTaJy2VX6na+rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58312058"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="58312058"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:24:38 -0700
X-CSE-ConnectionGUID: B2JTt5iEQZymdAsC2LyNAw==
X-CSE-MsgGUID: m8ABxilfQMGQqtt+du+Y8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="155809204"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:24:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 08:24:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 08:24:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 08:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxBbyWmC7dIsTeIsCfjPfsBobf+2r/WEg+RwtXpWrS6Adz/LFUiMnOw1xH5pn+dmxz33i2/ttKbxqi+T+Wc5QCkcdtGGAoTVgU1zNFEsPuIh9SW5o5CacCQ50R1m1lyURJCK2Kae3fQl7lzR0jxHFLys4jl90bWHDiydRO4I63itxY0w1AuEHuGLz4CyHXyD4NLpOdABATAAv/zTZp0iCF01DqJzUcZTsAoMhMBpu93ccEWMt3Ft5wNJpF7v3ksIjntFfgJtUB+NeyJHLNEG0g5Vw3JUu0WJacRvXWmMaQ4Q3tPgYCxMgG5Oy33HA8ylI/0LdZAQTf1HXg/baF0OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bg2Iz+IcA2PgnOB/qF6cO4S7jAQzrr4Cao0uHYGnns=;
 b=BRT7/0y3CX4eCogYJWRnFQpO7twceCxivrzl0ij/TfOE/ODtjWozo0O8lyP7uBUr4K+VXd1lJCGmwx1+EFB6Ndfj2S+OY282KZng0ebN1HIp/GqQqAinPamX8ca/5XhCGFBAzVcNxkVZ04vVbag6JJqojYcEO0aGPyJt+14+0elxYQEPD/6UK5nlY5YGVolc22Fk1JNMzWmNhubftpO8wbKKYkqPa8duzd6u5YgLvYqixS74llCB+DsPY8so9PvAH0P9iy2HQAw0P9Vwiya/JhhGAHC2KejwZj+Mof3q2hdLh7soswb4vFOYIVO8xhEMDoYKjfAL8w49mqNRTcSLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.32; Fri, 11 Jul
 2025 15:24:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Fri, 11 Jul 2025
 15:24:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Wang Haoran
	<haoranwangsec@gmail.com>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: We found a bug in skx_common.c for the latest linux
Thread-Topic: We found a bug in skx_common.c for the latest linux
Thread-Index: AQHb8UCNKJmNDlxmSkGVIIcAcMLmL7QrO/KAgABFNYCAAPLogIAAl1Mw
Date: Fri, 11 Jul 2025 15:24:34 +0000
Message-ID: <SJ1PR11MB608322D580CC951F58A03B1DFC4BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
 <CY8PR11MB71349230AB9CF3347D333AC48948A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CANZ3JQQdNGjzkAY-VUbs22sveHCsvCtgVkUApfTYFG7wGw1gCg@mail.gmail.com>
 <CY8PR11MB713497AF56976DEFD1B8EB3E894BA@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB713497AF56976DEFD1B8EB3E894BA@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB8513:EE_
x-ms-office365-filtering-correlation-id: f1972072-31d7-4837-ac6a-08ddc08f0a56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWQxai95WGlNUEozWE1wbFpNZjRzQi9NVGRGbUp1RXBSMjNiZGp0TDRxVmhO?=
 =?utf-8?B?YUt2c1VqUmtDUSttc3lDdURyZitvVGxQS3IyaEJCODJUSGErbDVMQUE1WkVw?=
 =?utf-8?B?cGFOYWFHT1NrZW03L3lLSVlFeGkzYTlwUGJnN1dJbzNGclozN2I3c2xiL0hs?=
 =?utf-8?B?L0Z3SmVIaGdyT0VFNjQ0UTlXaVZ3bGNJb1kxNFo0MVNKbjF3QUQyaUpNQlVS?=
 =?utf-8?B?ZDl0ODY3M1dxY3I5SzRqKzhrTk44aldFZ0h4WWZyQ0JFelZWMEFpczhHV29F?=
 =?utf-8?B?LzhnNndXeHBmS0FSYTFlaURpTlV2bFhJZFlLMlQ0VGtWR0Q4WU5LcUs1cW9r?=
 =?utf-8?B?dllsRkFzeERqRVhzaEg4UnVib1M2SVY4MGNKNVlyRFdXaFgyYlJJU2NtWDV2?=
 =?utf-8?B?ek83Q1BISWtnWUpOK1R2V2JWY2prY0NlNVplUmhyZlU2cHZDVEgrY0E4eUxl?=
 =?utf-8?B?bXcyNTNFR2s5dTZPK1liRUJqdHhSUzQ0MHk5dlFaRVVJZEpRaERLd0RPVUFl?=
 =?utf-8?B?bCtGZWhlMkV2Z2E4eUorRm5oR2svc3pHdFdySzA2eHFCZ3pjbEFGZnc4aVRZ?=
 =?utf-8?B?cTk5a3Jwd0hIUmw3Z3lNY1VCa1JQN2VHeXQ0M3ZWMlBjSEZ5VENsblQvNDI1?=
 =?utf-8?B?aTJydStQZGN1MGdKdE1GVkQwaHpETXVEMWxWK1k1a1c4d0pHQ091cys3Qmov?=
 =?utf-8?B?dnpZMmpEdTNnbjR4VUgrOWVqMnp4RUV0cURaWU5zTHREaDRQVHFlcGJ6SStF?=
 =?utf-8?B?UW4zTk14WEVlaDQ2ZUlSTHU3K0lEMTdMRVVJbW5Ua0kxS0doM2lGd0I5WWRG?=
 =?utf-8?B?MmtHc00zWm9XUlFJRURGWXRDSjhwZ25iSUpydDBXd1lsaWZ4UkhzZ0lkS1dQ?=
 =?utf-8?B?Q3U2NlozL1hKazArcGNBdDY1a3FpRUg1cFA3SWpUVkszVVhYU3h4Mm1ENmRk?=
 =?utf-8?B?bGZ2Um9WcEF4RXFrOCsxSVhGWWd6bGUrclhrUTBlOERJc0M3L1UvUXQxeWVO?=
 =?utf-8?B?bWUvZHg5MUVuV0cvRUVCOXo4eHcwbTg0ZW9obm5la01rYXdLblVCUzlyWTFY?=
 =?utf-8?B?SHNQeXBFb25IWUhzUzlnb3d5bFhZTDVTcGlYbzRiczF5b2RVbmI0OGh3MFZa?=
 =?utf-8?B?WHlCb2N0VnVWZVNmcjRINzB3TFg3RklEREk3SUZZUnVGVjhYd0xDMEVETWF2?=
 =?utf-8?B?MytvbjU1L2g1aDB2REYrZjNaZDlMQ0c2bXhXWXVSZDdrQnZKQVExTW10YXR1?=
 =?utf-8?B?VzlBcFJIYUhjZVprd2FyQWhHdmhodk9DSkFES2hoV21WQ0duUTVGL1Y1RGYx?=
 =?utf-8?B?OERUdEt0MTNnQ3MyUWRxSzU0bUpiMzJ2bENTVVo1Njh6THJxbnhOT3hjMk1x?=
 =?utf-8?B?dStBc3dnSDV5UG1FN3FQRkJBSzZmcVZ6MTZQbXNXc24wdEZKVGlPcXRzaGRj?=
 =?utf-8?B?N2U1d0Q4ekhzRVk4d2pybjVKS1F2OTl1TENOdkEyUzAxbWtCS1UyejJJdUov?=
 =?utf-8?B?RG43MjNCSThPWTZybWNTU0toRmQrSWUvSllPNCtDVEFQMVNEN24yVUFOOUhI?=
 =?utf-8?B?cmRNT2tlTndkZ2R3OU9jUGIxZUhiVmNTN0ZBcU8xUWNISldTVStKdERQb1Ny?=
 =?utf-8?B?MkFqWi9IRHBibDZ1M2lBMm9ESXVsVndJU0NYNllFUXl2ZWRGeE45ZnRzUy9m?=
 =?utf-8?B?bHVidFBZUnpPaUVvZXJieDg4Vzh2bmNPWjQyaFM1UFQ1ZzdHWWJiUGFzbllW?=
 =?utf-8?B?bEkreFczSWRXemJrUkEvbCtXR1o1OHpxcmFsMmNWSjJISzVGNUcrcnlZT0dP?=
 =?utf-8?B?T2tpVGd2K1pVWDlYY1pPQ0c4Qkk1aHk4YXIvTkNPYWFyUjE2aEN4T1V4eDNk?=
 =?utf-8?B?UHRjR2p4NHh1bFdUYithS0MxSFBMaUNNbG85V0kzNlFwVGpEamNjQmVxZVhp?=
 =?utf-8?B?d1JBd3VtM0NveDZwTXFaNUFCNmlMQjIzZzVZbEo4bGxWWHh6SExDM3FOQkNu?=
 =?utf-8?Q?hnaCU06gAvA/NZR2u9D6be+D/TXtKo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE05M2ZTK0Jka3AxNFFGMC9zR0RrcGNaQTBzV2xtWVhycEZlTk1ybnorZngw?=
 =?utf-8?B?WWVVY2U1MVh1cTRyWWlkMzdMT2Y2UEtnMm9uUUM3SStlOGdtL0FWNkIzcXhN?=
 =?utf-8?B?OGc1NHdaSFAwdDBRS1liMXcvMWp0dVFZZ0RXQ2hsbU5Fak51aWsvN2JOcUZU?=
 =?utf-8?B?dU9mMGord3lrUUIxbkxueDFNTEJkVHJ4SFBEWkpEQUpyRVpORDN3RGhRZHV4?=
 =?utf-8?B?eEN2NXpHZ2VMMVBSQjkvdXBSZm14VkJaUkpwcFdVOHVJVDB0aStNbnhsV0oy?=
 =?utf-8?B?ZE1OMElUY2UzQTZGeFd3cWhwaEFKTTJ0VEF3TkRIZVp6UDRIREJhb1hoczlv?=
 =?utf-8?B?MFJ1RGszZmFFbWxmNTYremJwK01wYklCc3haZ3VsTmlZUk1aQkVhb2hVUG1z?=
 =?utf-8?B?VXp0eEh5OTArYkdCQU1VeWg0eWc0ZU9uMVFNRGdzUjBuSDZ1bjhhVnZlZ2U4?=
 =?utf-8?B?dXhHVjc4blhPT1FuT05nTUV6ZUN5QnVyM2R4RXpuTnlNcFVqNnpuamM0bzJL?=
 =?utf-8?B?OGhSS1I4RlY5RnFQNkZrcDhONG1hS2dhNEFSenI4b3Rta3B0WFV0RTMwL0tn?=
 =?utf-8?B?TjBvRkpTRFpsK0dVRVIxNHpOeHpnWThYSkdRbVpBeE02L2EvUncram1nTm45?=
 =?utf-8?B?ZENUdzhabi9mekM4RVNTNmZpZjhwNE8xcnNWd0hWWDJVbE9zU0VMUlhTVldp?=
 =?utf-8?B?djc5akhOanJrL1ZVWXVHS29UM2Y5WTAwdDEwQ3lBS1dkYVkzSU56MTQ1ZUMy?=
 =?utf-8?B?TGpsOHpTWXBUM2tWWkZTUFRXUVRwRFhOclR0cDd1TjduK2Z6bUY1WHNON2RD?=
 =?utf-8?B?Q0M0UHJ3VWh3R0lvUVk3VER2UjVkNElHVmtpcTVXdmNJYWpIMTFjSmNPUWVi?=
 =?utf-8?B?QytVazE0OEYwWGN6Q2J2ekVYUEJoMTlwaW4wbkxhRnc4TEsyMEsxYUc4VkJo?=
 =?utf-8?B?cmE3S21MZHZrNkRkdmVtT1NrZWdIcXJrMkkxUWpkVytSdTEzK2hjNERjank1?=
 =?utf-8?B?dkNKaTdSQ0x3RnllV1pWS3hXUjhtci9mU0Z0OGhEMEhFVmRxbmlzYnAvTWNH?=
 =?utf-8?B?Q0lIRG10Sko0VGc5amJrMnhQSWJORjNlQTVmRy9sSkgwa1p6ellVTEFXWHMw?=
 =?utf-8?B?L09yV3JzMnE3WmFDdW54N2FFdDFKWDhFRE1sYytVM0U0OW9CUndLZWU5N3Y4?=
 =?utf-8?B?SDg5emtZWHkwYWZqYWlLWHkzYXExVFhmdzRSd0k0UTlQaE9GMkEwRkVHbXVB?=
 =?utf-8?B?T2kyR2ZkS1dJR1gwUTFYUDNLYXVGVFhLUXJQM2p6N05JdXM3MHdlemhCYVFN?=
 =?utf-8?B?VXFnRUlYekFOSVJMZmUycUFSYjk3VGZnY25HakFYQVZ1RXo0U2ZQUDZHUFBp?=
 =?utf-8?B?a25PaFZKU00yTzNyc3M4TkM2WllaMDZQT1hXbThwaVh1NlF3dENWMW1JVGli?=
 =?utf-8?B?V1BQRGk1NDJLcFhMdDY2TWZYbkNLK2VTaUtMNDdjTUhmUEZ4VHl1MlozZGE1?=
 =?utf-8?B?eW9kV3JHWW5BdzQ4SGVNMk5ZNE5oTjhhR1lXZStWU1lqWngxOTI5Y3k1bjFT?=
 =?utf-8?B?cVJqYzJpTy9CemlGbkRFMlNrT1VvS2Uxb294UEFQVFF2R2tiTGdUS1RMYm5q?=
 =?utf-8?B?aTRySzc0R0FsQlY2eUVmWmZUOExpMHA2Q0FvYWRrbEh4RzFrcTVKTTdhYmI0?=
 =?utf-8?B?OStXcXNqYm1VQlo2V0t3a2VqS2dxVzA0c2hMZnlsakhzNk14MWFjRkFRSXFQ?=
 =?utf-8?B?ME1ZNXJPK05IS2RKazVYVnVxRkFRdlVPdXdiMGh5bmRYR085bDlQQklDVnps?=
 =?utf-8?B?WWV4cWtLMUlNa2xCOTViR21aSVpJb3JiTm9sK3gySjUyQmQ5SXFRZ3RaeFBT?=
 =?utf-8?B?ZlZMcUpUdFVkT2VVYUNVb0tWNDJQQk1RWU5ISERqSmhYWXZhVEFEVVZUcVNC?=
 =?utf-8?B?dmorb1ZvQjZ3cFgrRlNXc0RxbmJ3ZjYwMzQrYU5DYXZhY0h1KzJDdGFDdGVu?=
 =?utf-8?B?bTBwQmxkYlJaMmtkUm9FcDErQnRueGE0cXR0c0ZnMTZFdEVmQ0xJdHowZ1NF?=
 =?utf-8?B?WVM4WHQrNXUyRWhLNWYvcVhvejlBcHQ5cGJBQk5SZ29ObkFXa2tGMjlYOHFS?=
 =?utf-8?Q?Y5a96MG4x9VjvAZaxEbZyuAhe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1972072-31d7-4837-ac6a-08ddc08f0a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 15:24:34.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PY8kDg3/q2zQdux7x8qpVkRsgQskLVvjvtYTtFscZaynbfFGaBnLVqpPqsTdrniy/Vn3EvRIlVudzXzpzNjznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com

PiBBbHRob3VnaCB0aGVyZSBpc24ndCBhIHJlYWwgKmlzc3VlIiB5b3UgZGVzY3JpYmVkIGhlcmUg
aW4gdGhlIHtza3gsIGkxMG5tfV9lZGFjIGRyaXZlciwNCj4gaXQgc2VlbXMgc3RpbGwgd29ydGh3
aGlsZSB0byByZXBsYWNlIHNucHJpbnRmKCkgd2l0aCBzY25wcmludGYoKSB0byBlbmhhbmNlIGNv
ZGUgcm9idXN0bmVzcy4NCj4NCj4gICAgIC0gc25wcmludGYoKSByZXR1cm5zIHRoZSB3b3VsZC1i
ZS1vdXRwdXQgc2l6ZS4NCj4NCj4gICAgIC0gc2NucHJpbnRmKCkgcmV0dXJucyB0aGUgYWN0dWFs
IG51bWJlciBvZiBjaGFyYWN0ZXJzIHdyaXR0ZW4gdG8gdGhlIGJ1ZmZlci4NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBUaGlzIGVuc3VyZXMgdGhlIHN1YnNlcXVlbnQgY2FsbHMgZG8gbm90
IGV4Y2VlZCB0aGUgYnVmZmVyIGxpbWl0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHBh
cnRpY3VsYXJseSBpbiBjb2RlIGxpa2U6IGxlbiArPSBzY25wcmludGYoYnVmK2xlbiwgU0laRSAt
IGxlbiwgLi4uKQ0KPg0KPiBJdCdzIE9LIHRvIG1lIHRoYXQgSGFvcmFuIHJlcGxhY2VzIHNucHJp
bnRmKCkgd2l0aCBzY25wcmludGYoKSBhbmQgYXBwbGllcyB0aGVzZSBjaGFuZ2VzIHRvDQo+IHRo
ZSBmaWxlczogc2t4X2NvbW1vbi5jLCBza3hfYmFzZS5jLCAgYW5kIGkxMG5tX2Jhc2UuYyBhcyB3
ZWxsLg0KPg0KPiBATHVjaywgVG9ueSwgZG8geW91IGFncmVlIHdpdGggSGFvcmFuIHJlcGxhY2lu
ZyBzbnByaW50ZigpIHdpdGggc2NucHJpbnRmKCkNCj4gZXZlbiB0aG91Z2ggbm8gaXNzdWVzIGFy
ZSBjdXJyZW50bHkgb2NjdXJyaW5nIGluIHRoZSB7c2t4LGkxMG5tfV9lZGFjIGRyaXZlcnM/DQoN
CkFncmVlZC4gSXQgd291bGQgYmUgYSBwYWluIHRvIGRlYnVnIGlmIHRoZSBmaXJzdCBzbnByaW50
ZigpIHRvIHRoZSBidWZmZXIgZGlkIG92ZXJmbG93Lg0KU28gY29kZSByb2J1c3RuZXNzIGlzIGlt
cG9ydGFudC4NCg0KSGFvcmFuOiBQbGVhc2Ugc2VuZCBhIHByb3Blcmx5IGZvcm1hdHRlZCBwYXRj
aCB3aXRoIHlvdXIgIlNpZ25lZC1vZmYtYnk6IiBsaW5lDQppbmNsdWRlZC4gIFlvdSd2ZSBwcm92
aWRlZCBwbGVudHkgb2YgZXhwbGFuYXRpb24gaW4gdGhpcyBlLW1haWwgdGhyZWFkICh3aGljaA0K
SSdsbCAiTGluazoiIHdoZW4gSSBjb21taXQuIFNvIGl0J3MgT0sgdG8gYmUgcXVpdGUgdGVyc2Ug
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpTb21ldGhpbmcgbGlrZToNCg0KICBzbnByaW50Zigp
IGlzIGZyYWdpbGUgd2hlbiBpdHMgcmV0dXJuIHZhbHVlIHdpbGwgYmUgdXNlZCB0byBhcHBlbmQg
YWRkaXRpb25hbCBkYXRhDQogIHRvIGEgYnVmZmVyLiBVc2Ugc2NucHJpbnRmKCkgaW5zdGVhZC4N
Cg0KLVRvbnkNCg==

