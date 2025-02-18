Return-Path: <linux-edac+bounces-3116-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA5A39153
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 04:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC18D16DB10
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52615B115;
	Tue, 18 Feb 2025 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1hGbaBn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AC17C77;
	Tue, 18 Feb 2025 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849610; cv=fail; b=OMuq70EH0eFGjyq7GuxjSWhcAGmVhwqsBC6Lkc0zVzrK6Yhl8aXU/AutCJzaM66JjxUc1mu3Glv224x6yqsxo1+woJt83OSZocRsG3dShBVO06tclp10LifgW3A+n4Ez3egg6+pjdgcGKDaU5gSvuFcSLbYqVbwjhL8mguIMaJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849610; c=relaxed/simple;
	bh=zJmy/+5hwh9Q1WQtK7uVPdcb61CONzvlbLXeQTNgufw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l0LBo38sa8qephIlMRANWFLY5t9nQxgn/W02Fm7VqSqSgTBLqRTxjWN+9GnDhmGbvxvrHoTFo1O99UlBfZIE2cd/L9+4ZFnRjsiqkv8d4tQmcTjuws5zBdP/F1eKgxfLfXLtxLsJPk6gpeFe+dp/2tX5z5dsPTOXFsLFmrb8o2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1hGbaBn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739849609; x=1771385609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zJmy/+5hwh9Q1WQtK7uVPdcb61CONzvlbLXeQTNgufw=;
  b=V1hGbaBnVC+K1o9qTrorse1EXhj93EktIVuJrrftIt1aJgKb6mMwdIDy
   GjdU9kj7uxoaZcymvWfrx7qtb2hjMrgzG46PLB71jFNvJ7h2q95Y4Tvz5
   9WezW91gjbCLtQjROz+AhVaDN+AHd6xoxc2ODcMo+cJFAh2Ir+fZywvAp
   oDrLIzgvYpTJFpyaDmJyTELDQZkxjWOm2Y4WAL5nVHicR/nYim1JzCp4k
   bh1FQGt31bLSz59dIPCg5C8N0j9K52rwWtjVZdonKlXdY1WPTpd0UCR28
   fR4JSHrjRGsiS/JpXuBd9x1sn2X/dm/AFkjFsC4VUbIIYhwrl2BPMKwj0
   w==;
X-CSE-ConnectionGUID: LexvujROQYGED0GSP2owzg==
X-CSE-MsgGUID: L6OFCuOJQqujjDWScyA9ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39767418"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="39767418"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:33:28 -0800
X-CSE-ConnectionGUID: rGOGT5V2S9iKymp2hBMS3g==
X-CSE-MsgGUID: s9DLhVMZTiGXZt+eCOFYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114924756"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:33:27 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Feb 2025 19:33:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 19:33:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 19:33:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6Se3HHTu5QTOAbgG7JEmBaGnr7T2wS9qAPcd+ElJLrdelPPrkj2HvI6tPWrpMJQ9nRzXpk57g0DDmD/tbf8b3djrIPnnVKjFAoyX7xvVl4CJSe/FQGai53SAnujZlm1oRV++x0S4lORVc8wq8TK+USdeQtZcuqCFHog6aaFSqhXW+Q3+7zF5sIbW/7TaWkFkrZt4tWHMpLx/+l99aogIZxV7u10/PfUBafZwSZ92+PTstdFCiECVV7WtVUZLMAmBy4gODO58vhuj2bM2y8eY1gqGfsKwoEymiPYQNOlJuzEMIMdtFZH4Xm9kePlMWOarSRrqiM/h4UHK8VavSafCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJmy/+5hwh9Q1WQtK7uVPdcb61CONzvlbLXeQTNgufw=;
 b=gGIgVYK6/k9TTK7jjFDzGILEuPH0Q/brrXeev210KQ0Jk8ZN+C3vbXl8FVHt5N8EJTpxg1Wi8kSRDyAC46HpEXXELC5MujW+jAeRSMAduRQVBcZBXnyPUXKhOF02NRaSmkMggDnDI14A+iHFVqy59jjKrwLYe1gtmPNrvToreJC7nVHNC+UfJF7KRdaA/JDFe5VvShJD5VMED1DkkNcdKGup5gPHDazOpiECvrOy4q/IJuGdmYu/G6/SGp9KT3wfsJcxDY5fo6yYkfzXiUf4390RPFhlm3DVOXRzLzAx4JCWqObS5yuTVe6PPaVFCUYF98xn1ilYwSqVAv+WKwpDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 03:33:08 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 03:33:08 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 08/16] x86/mce: Define BSP-only SMCA init
Thread-Topic: [PATCH v2 08/16] x86/mce: Define BSP-only SMCA init
Thread-Index: AQHbfjgKfHMRb/Vi20+tkiMUCFxtK7NMbgwQ
Date: Tue, 18 Feb 2025 03:33:08 +0000
Message-ID: <CY8PR11MB7134F491D46892FD5669E3C589FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-8-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-8-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB7468:EE_
x-ms-office365-filtering-correlation-id: e92ac79d-9455-46f0-1dcc-08dd4fccf676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXJKTzVhalg5b3NEMVdMc2xFZVRDVUxKSk54WWVpeXYwL3pYQyt0S0oyWENu?=
 =?utf-8?B?dGtjRTc5NWhueHBUL2FxeDF2TXdYSWtoZ3haMmU0OW9JK3A3YWhqSTdxaC9B?=
 =?utf-8?B?aUltZnAwWFdXVndIWWR2Tll3WkFZUkdYY3AvVUxpVVpVc0I0SGxUNjg0OXo3?=
 =?utf-8?B?WmN5eFVsWkl6YWM2aDFXWlVHQXl5bHk2bU4xRUhNRW01aGlRWDBZYlNuWWg0?=
 =?utf-8?B?bXkyNSs4TUhyNmU0TVZIWWpyTDl1ODhUS0RLcXorUUJIdmVSbWF1N1g5bldv?=
 =?utf-8?B?aHhMQ3RMazRxM3plbStTQStKYkl1V0gzVndHYXdSanN3SnhiMTdPQjhyUFZK?=
 =?utf-8?B?aGhsYitaWjlVV2VBSkNrVHpZSG93R0xJekRxTndMdTVXQlc2RVBuN2oxc0NO?=
 =?utf-8?B?ZFNwYzdEMVFWNUxuT0l5b0hxMkJ6VXVqMEJWc0RtRkZLODJiZ2lucjU4L3VU?=
 =?utf-8?B?bTFMSlpYRlNEY1VwL2cxM3Uvc2ZXbngvZmhmWFVFYzZPL3Fpcm5qd2ZRSkFX?=
 =?utf-8?B?cGNLOWhGWkoxd3JGUGwwZE9Ddmh4V0ExazY2b2pvU2hreHArWTBDMTFkUWxl?=
 =?utf-8?B?N1VzUUs3WDhlSEZqWmhZbnI1TStRTXdMMzhnVElJS3RnSURhbkkvbkN0N2Ja?=
 =?utf-8?B?MlFnb29IeXhZU1R0U0ZxRjFJUSt4VHhzV2RwQmwvRDlLSlVadG9CM0QxS0pK?=
 =?utf-8?B?TU9JOHpia1R6YXFvcHNTc3hzZmVEQi9RZUdMYmlVTVFUck1XbjV4VEdNRWVw?=
 =?utf-8?B?Y2JoRnRmb0dYY1pscmJ5djV0Y0xLNEhKSDhZck9rZThEbENVamFzS1UrbVFB?=
 =?utf-8?B?N2ExWTIycG1wZFd5TlR0L2pXOERJMU5XeDkxWlh2NFJMZTBMcHU0dWJpQnJU?=
 =?utf-8?B?TTRVcUlnL21KbmRxVlQyVkx1RkNwbk85SzB5ZWVnaDdqQUMwaXlyeG1yTGsx?=
 =?utf-8?B?cHU1THc2Y0tXdExaZ0JsK2lsQUFsQ1FRZmttTnVobjNZcmF5TWhJSk8xdzVj?=
 =?utf-8?B?WXgzNlRyd25CbDBDbjhIQjFLaFZXR0gzRG9Ia0FjTURaK3pBd3lra3VqR21Q?=
 =?utf-8?B?VXN1SUtvNG1VQ2ptd0M2SHFwWlBIYVdpcWxKb2prVVRTalVWRXBOYTU0NlIr?=
 =?utf-8?B?NFVSRkNpQ0NpbEpaNHorMjV4MGhmZkh0ZFppSEl3Zmpxb3J2ZmNLS2NMMGE0?=
 =?utf-8?B?cVE5QldvV3pTTHovUDdIdG40QjB3L0ZnaEVXUjVCRVlMNzIvZlFGMk8yY2FJ?=
 =?utf-8?B?WkFuMkRKRld1UE1qdTZFdU1ZMHphSThCTGhYYjBWS2dBRkQ2OElmbmJPdlln?=
 =?utf-8?B?WlhOSHBGcFRqUnplQklTTEZTUDF6eGdTVGQ4UDM1VDI1dHNRSjZwTkhGUUth?=
 =?utf-8?B?WnNwR29RNG1qRWQ0VlY4WGozVUlTNHZJUnM2NlRNRkp0c2srRzZjOEtOVTA2?=
 =?utf-8?B?b0drRTFUK3dybHlxZ0tXTUp2MGt4OG10WjJrUElPbkFhdUUwVmJ4V3RFcUYx?=
 =?utf-8?B?K1pxZDlKTFY4cEpNYmJBcTBvNFZxcmRHK0phZVNQZEZIaExOclZsQXBlN2lF?=
 =?utf-8?B?azhMZklDS09TcTFKUE40MGtsR0g1YitwU2NkSUlTUDJFZlN6QktDaUVDQTc4?=
 =?utf-8?B?VythY1JZY0YwMXhHV0NxSkFuWVFnSVN1enhGaXJ6RExxZzVrUUlHaDVaQTVt?=
 =?utf-8?B?S0hyR1dZWCsybkRQUWh0QUxDOFUzQ0wxdHRwQmJveGplSGtYQjJ4WkdYUW9r?=
 =?utf-8?B?bUlRQU83S2xGaTdCYVpBVXF2cEU3OEV4am42UjVhdjJBdDgyZGFWeXY4dndH?=
 =?utf-8?B?dlRpTWZ2UVZNcmg2QnBNaUFKODk4RVBNUkpESDZyMkhNbHIrY1JMQlVUKzRV?=
 =?utf-8?B?d250TmZETTlLaXJCZ1BZejQzY1dHMG5YbE9HdDdQTFROTWpzRTBBTHhJa1RX?=
 =?utf-8?Q?uX2gTLyIYabYgTNFQh4bJh2WsQ8pAmwK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5HZm96djM2Ry8zUC82amN0YjVPL21TblI2aGExTlRSRjNmYS81bFhCY3BP?=
 =?utf-8?B?b2pJd3RPbDQwVWtjRGRmRnZ6RFpYVlNUanp2aU8zcG16OGt2Yy92UGpoWE8v?=
 =?utf-8?B?UnNnYmNTZnRnRmZxNzlzNy84YWZmaU14dXRONm5GWkhGRXZHc1BFaDY2ck1D?=
 =?utf-8?B?em5QWlFuNE15VFEvbGROU3lGMjdNMHM2OVBMdzhGK2ZwdTQzNWdUenFuKzJX?=
 =?utf-8?B?SDc4V2VIMnJ0NVhzVGdlQk8xZzd3R05zL1g5a2hieThxanBVODRyeW45U21P?=
 =?utf-8?B?Q1BIb3FsTnJ1d2czMS9xclpYeitnY2I5T21Xa0x4OEJCd3BuNGJSUXFwM3E0?=
 =?utf-8?B?TjVwNzRkMkttYXBQQ3Bxbys1NUpFWnovL3FIQ1JORXVYcUpiSVpadTE4Rnll?=
 =?utf-8?B?NGtFUTlZc1dSdDA1N0VPRnlobDhOcjZGTGhyUE54eGpwa0lXZlBLQkh6Skhq?=
 =?utf-8?B?SGRsQ0JNK3lyRDNIYTR2TmtTM0VrSW95WS9INHB5MWg4R0lBdTF3QTFqRjN6?=
 =?utf-8?B?RXhJSnZMQ2JxNXc0R3N3TElYOXdwTFN0aE8wTmpQNzhnN0lJK2I0RTJmOHVk?=
 =?utf-8?B?RWJVWHV6SWpIcUZIaE5JUG9xaDFPQXRqWVh3MUlmV04wMm1nZWZrU0ppaWUx?=
 =?utf-8?B?cUszSCtWdlZKa0QwR25zejB4SXhKbDB1Q3NSMUdTU2RPZHFlWEFmU0RoU2Js?=
 =?utf-8?B?TUVrS1NHazBzQUd0Q3hWUjVBTHpRNWdMRFA4cy9MdGVtaTRaMjQ5S3M1dlU0?=
 =?utf-8?B?cjNTYmlTdWxWd1R6S25KMzRzd0ZVVS9IRVhyNmtYV3EraUtnSkg2WDBqL3pj?=
 =?utf-8?B?M1JQdWR6NGErRlpGbmFEYjRVQ2ZyNGN6RmZickZQRSt5ekFBQU9MTHlPRm1h?=
 =?utf-8?B?cDQwOXFwdWRSMGhSODJROGZaWEVWVUp3WXhKVUkxQ2k4aXA3YnpMczcrampr?=
 =?utf-8?B?RUxTWHFpT1MxTFAvNnFMYWdBcGdZTCtvU2hDRFNScFdlbDlQOTkwRHYyWk5k?=
 =?utf-8?B?K1o5K3NuN0pOTXRpNFUrS2ZWRFNSVXZNUTYzNTloNXgwL3ZjeXo4KzNIQ1pS?=
 =?utf-8?B?bzluZ0hNWnIrb1FTbHJGY2lNR0NWaHRHQkx4cEFHazVnck9nLzl4VE05ekxI?=
 =?utf-8?B?bnBlSlJPUHAwZnpYazBxY0I0ZThrYTdtVVo1YlFwclEvWTkzYWhydThpYmM4?=
 =?utf-8?B?VEFkZ3M4aGdBS2l3bThiMFBzVEhqa1Z4b2RCay83RUlVSlFYUjNubDVVRlBv?=
 =?utf-8?B?RlhLa2xxNlpPUkpMOTVITlVQb3pPL05WMHhqMzcwbzRweUxGQk9IOXp4bWdW?=
 =?utf-8?B?VEJ5eVN5QmE3Tk43RHlRWkFKU1NoSW9idDNkMlh1Tm03T3JKU3I4WXBMVlF2?=
 =?utf-8?B?UkwyMUE2TXRKdUdiTDFiRGVrNmlwaWZVRTd1ZVpQQ3BkLzNubklIeHRqbkR2?=
 =?utf-8?B?QkoxektwSDN1alBURTBrN1dCOUJLVURqMWtTNmRnUjg1T3NtVUtJWW5uSmVZ?=
 =?utf-8?B?ZU1wNFNSTzNCV3pWQ281T1EwSFlHdWpxT3F2YktuQXlNcVJTcU9ZSFZyRjh1?=
 =?utf-8?B?V1hVdWorSjZqQlNldS91ZDdXeHlOM2g5UkxEVjIyS2UrS09WTU5ZUCthbzZa?=
 =?utf-8?B?ellsTGF5YU53UEdxRjltN1dUTTNoZm90dGdkQnlqN01DNzB0T3k1enR6QmVU?=
 =?utf-8?B?TENTWFFnc0dVVE1BeW1lT0JBdmdxU1VnNHBQNjZuWXZ4VFBxalhDN1FQWUNy?=
 =?utf-8?B?dmZ4cDc1bzVtU3B3eTd6Sk1CYjgrZ3o4dTYyTDFQS0x3Y3VtKzBZRy9GZFJo?=
 =?utf-8?B?T1VSSC9mditnSFZsL3dmUGU0c0ovWVd4QkJMY1AzMG9XbW1LQ1dDS3RqNmJm?=
 =?utf-8?B?K0pRWmRHTW1pekJYdVdCNzhEYzVOQ3RMQ2E0SjB4bTNEMExBa0NiNEY4Sk4x?=
 =?utf-8?B?MVIxY1ZpTDBrREdVOC8xTmhjQm9lSnZ5TDBKQTRwbm03eUZNRHFwdGI2ZjJJ?=
 =?utf-8?B?WGdqR003Q3huUFVGTStwMSs3K3M3OG1mTGJ3SmtHMjhiZVZpK0ZDWlZoU3gz?=
 =?utf-8?B?OSs2Y00wVjhOanFwU3BHTno5VFhkN0ZUQnl4eW1hNG1HRnpteHZxQ3ZJbmVr?=
 =?utf-8?Q?hPVFa7cERFbrgCXGURFjhUQgz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e92ac79d-9455-46f0-1dcc-08dd4fccf676
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 03:33:08.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5psMKwA43yYY7j1PILKg67vrLnv0hRV9Mr9Rv/QzJhNuqnuy2nf3ELY1p7ozev7RAAnmRSjCjfkse8aeY4OXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwOC8xNl0geDg2L21jZTogRGVmaW5lIEJT
UC1vbmx5IFNNQ0EgaW5pdA0KPiANCj4gQ3VycmVudGx5IG9uIEFNRCBzeXN0ZW1zLCBNQ0EgaW50
ZXJydXB0IGhhbmRsZXIgZnVuY3Rpb25zIGFyZSBzZXQgZHVyaW5nDQo+IENQVSBpbml0LiBIb3dl
dmVyLCB0aGUgZnVuY3Rpb25zIG9ubHkgbmVlZCB0byBiZSBzZXQgb25jZSBmb3IgdGhlIHdob2xl
DQo+IHN5c3RlbS4NCj4gDQo+IEFzc2lnbiB0aGUgaGFuZGxlcnMgb25seSBkdXJpbmcgQlNQIGlu
aXQuIERvIHNvIG9ubHkgZm9yIFNNQ0Egc3lzdGVtcyB0bw0KPiBtYWludGFpbiB0aGUgb2xkIGJl
aGF2aW9yIGZvciBsZWdhY3kgc3lzdGVtcy4NCg0KTG9va3MgbGlrZSB0aGUgaW50ZXJydXB0IGhh
bmRsZXIgaXMgc3RpbGwgc2V0IGR1cmluZyBlYWNoIHBlci1DUFUgb25saW5lLCByaWdodD8NCldo
YXQncyB0aGUgYmVuZWZpdC9wdXJwb3NlIG9mIHRoaXMgcGF0Y2g/IFRoYW5rcyENCg0KICAgIG1j
ZV9jcHVfb25saW5lKGNwdSkNCiAgICAgICAgbWNlX3RocmVzaG9sZF9jcmVhdGVfZGV2aWNlKGNw
dSkgew0KICAgICAgICAgICAgLi4uDQogICAgICAgICAgICBtY2VfdGhyZXNob2xkX3ZlY3RvciA9
IGFtZF90aHJlc2hvbGRfaW50ZXJydXB0Ow0KICAgICAgICAgICAgLi4uDQogICAgICAgfQ0KDQo+
IFNpZ25lZC1vZmYtYnk6IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCg0K
Wy4uLl0NCg==

