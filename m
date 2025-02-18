Return-Path: <linux-edac+bounces-3120-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E7A39386
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 07:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B0188D150
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F71B425C;
	Tue, 18 Feb 2025 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/MxfgCz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2D136A;
	Tue, 18 Feb 2025 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860993; cv=fail; b=ceLIRjLR/aiEoDZaOOV90myaIyTthEdIZGSYT6k9wzHgELW9du5GxaxLLv7x+Jlg72GrSpYXx3CUwoSwZ2pEkgRqxlXIAUbtMwEJBssA5J8pkjXAanyNBctOK+7eGWcKIZURG9h+cSNHyDCTGFqXy5ZOMRZxjGLb2FgBEkMn9vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860993; c=relaxed/simple;
	bh=6jstPKVGjhnt7y7xVdbbBSURvv6aYlrzP/eIqSJPDms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NN5Fn56MzwZdQN+08hHbhsVFCrrb+K9gIYdv3KPn311H3Q4xrkpoVDlPhwZb/RvXfsl3L2xpng2DYisIevsFQTGv7GNMXKRSA4+8d3s3Cd2Ufz0SNIU479Jn7CusNd1ZAkesPHK/KeQZUkF1yfuOrVHy3K766Vaw57+oz0CxI/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/MxfgCz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739860991; x=1771396991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6jstPKVGjhnt7y7xVdbbBSURvv6aYlrzP/eIqSJPDms=;
  b=A/MxfgCz/4qosO6PkcpxD1tJ5vdIb0a0S96RR5RN91EZHPAB/EbpW6yt
   5fqqE4p9NCEj2w/W51OP/p5/J5y7eoCqli8xxiKPrKyjmTZi+iKsERmie
   ikKL/pioh4iS5pKVD7l/DcxWzmq6onDwmHBWhzaDBU4ZLvSpqhy42EG4s
   EpoQ6ByeyAaNxMMcz5Po4QFY/6qRc+27P4lHM55ttWh6i2OtclAo43QGd
   Ivn2G+AVuScWu47d+Yg08LQkE3xu9fgXYKr8ay7G1aylwosL117QBfAtM
   piJAUByK6kJ90GgbicUBo20I6O+AFIgnGCHXqiLBE0BrvDqvyMa3WmylQ
   Q==;
X-CSE-ConnectionGUID: NPQwlA7uTtauuzo0rSBiBQ==
X-CSE-MsgGUID: nRr5ZJ8vSEq4K/enntsDxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40465656"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40465656"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:42:55 -0800
X-CSE-ConnectionGUID: uAgzCn4hRQOBlccB8T//FQ==
X-CSE-MsgGUID: EO6GeycCSoqJFl0Xrv4Y8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="114050362"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:42:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 22:42:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 22:42:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 22:42:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+yVkrqulXBG8E4v8/1sQoVbZFRQCF+RIGZ2UZDaGabHI7iA4bLYIIz/PITvpWuXOWSP4vYjLwl96vtXacuKyEp27xBMNUArUFsgGCVmfkV+BaFqz8BZGQ74HJAuY8YXzizhTwehT0zXII89fGWSb/vLj4UOJwziJUtPtibQIv4vxGpFK8tKqjZFvhOXmt3i+BKGgxlnnK7LRr1Tf0/gGGQWcsG86erJ1QEmRCxsBSD8S+rOOMnO78HxNQYsf4p2JjX0/yDdOmOZAgxxDQtjA7DbeNtqBD3Hod377RcCf3/vr3vfQ2MNoacFzPxOSZTV51wGfdwz5ullHg1CCb0JtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jstPKVGjhnt7y7xVdbbBSURvv6aYlrzP/eIqSJPDms=;
 b=uyMVSjVAsrWxT4soPupaCTRl5C9Gp4AeIhWm5FDxFN66f/YXOhKET+hU1Xlkw4nasrtimASiN+eRYaaCB9Mkoj1hXnNGpEgJfr3Rc70jkTqdLWIeiAb3s5cSSflctieVESHFx5nlmbr7qOEzYP9hIkE6wSjMZ5G8IWDCOUcF5PbLnm3qxNqBSki9qXRbCAcTPbJW+GqB9aZNzW6tdCN5OB9XaKYoC1LUU7z9F3QpdT+v0aJO6YcLVjdk7eI6PULZvTicaEDtzzdnF9vn3E7qW9lSVFDHSNXtMAV43uTIPwjPLf9Smuu4deZv1hIzvqSaNk/yPwyIwr/BHv6+fEoxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 06:42:52 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 06:42:52 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 12/16] x86/mce: Unify AMD THR handler with MCA Polling
Thread-Topic: [PATCH v2 12/16] x86/mce: Unify AMD THR handler with MCA Polling
Thread-Index: AQHbfjgDijST9kmYUEuwCT2VCt4PTbNMpAFw
Date: Tue, 18 Feb 2025 06:42:52 +0000
Message-ID: <CY8PR11MB7134A549EDB172C3FB87233989FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-12-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-12-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6919:EE_
x-ms-office365-filtering-correlation-id: 364e8aac-3ef2-4fcc-7e9b-08dd4fe777fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SE5sa3MrcFpvNWxFbDhKQjVrSVU4ZG5FNGlzM3E1Rm1pQzgzNWIxMzg0TzRj?=
 =?utf-8?B?c01sT25MRmtTMEFRbWQ3WS9mYlhCRDdJczB3Tm9CV01xQlNha0dvSUYreUl3?=
 =?utf-8?B?akY2NjBMaVRPeldqejRDZ3U1cFpva3Q5emtWK2hwQ3RCNXRLM2pMRjROU3Fw?=
 =?utf-8?B?OXlmUlV2dkl1RDF5QU5rN0RQQ0hwQTFkclRtbjNVc0w3QmdPa1pmY0JYdGRz?=
 =?utf-8?B?QlRQSE9zSkpURzZkUXc3MFFReGNzT3o0TTFQblBZSXZielZSVG1HNUo0RHNN?=
 =?utf-8?B?dG5kWmJKVG5ZZFlHRXFrRjZ6N3IxdVkvWmh2ZkFmTGRydFN2dTJjNENCaW9C?=
 =?utf-8?B?cFM0TUhrTU9PMGp5OHBncll5ckxPYzA4NTg3S2p2b3dwK1dablNxT2tobDZR?=
 =?utf-8?B?UE1NbVdvVkcreFBmakVEMDZqUVkwd3JsY1VHQUtuek5Rbll6YUhnRjVmeG1H?=
 =?utf-8?B?TXVya3k4UDBUWGhzSE5VYkZUVjJ0NDVyZGFpVkdZTlpDaENxSmI3YzQwVTY3?=
 =?utf-8?B?dXpEUURUWDBSM1dXQ0g4WkpXM1BUUnV3N3ZNYy8rRkU4ZFJWcFZsaDZaKzBO?=
 =?utf-8?B?S240c3UvYnc4T2hBY0pHS0VxcGc4cjNDNXRaOEIza1V5NG5QODlKYWErUE42?=
 =?utf-8?B?clEwMml5b05HSERqZ09MNlpIZHVmdHhLcXhwS1pCSTNyWVF2cVZsdTgxUmgv?=
 =?utf-8?B?YW85M1lMcXoxVkhadG9iU2FnYUM1QmFadktzdFMxZGpzZGo3ZXVud2FtQk9w?=
 =?utf-8?B?YnFzalVIM3NmQzc4VWJ0TnVYdU1udzd5bjEvbzVIcXRQMEIyRm9TcFA0N2o0?=
 =?utf-8?B?M2JoN2htNmlBRHFzVVdzRk5RU3dlbGl4TWtiNFR6Q1djRE91K1kzd1hUejA5?=
 =?utf-8?B?Rm0rWHI0QVNyeXk4cCt3M3IraUxwWWpYOHV3V0x0WndJVXBtblVZVzRQNnJQ?=
 =?utf-8?B?QWNLOE1lVzFSVU1jR29DOUhMdERwTVpoTHVmNUtBOTdLelVxR21nV1BvVnFh?=
 =?utf-8?B?cHErbEFlUWpCUTJveGIvemJrT0QrMUxkeEFkSnhrS3BnbGRsbVZUTzJOamlE?=
 =?utf-8?B?VTU4L2RXM0dBd3g5aGRtS2JzTTVuTEVETFI5UHhMZ0x6Z25ySS9SNW96RDVl?=
 =?utf-8?B?UmFObXVoNldrY1QvcnFORjdmYTE2eUtlQzRsOGpKdTF5NGFYcTZoalJST3RI?=
 =?utf-8?B?K3Z5aFU1TC9XdVNoWURpNE9MREE1M2MzTTZ0QlZ1TmxVVk0zMk4zVnA4RE9w?=
 =?utf-8?B?ZzAzZkFoV1JZM2ZvbnNjSWI1cHh6RG1OVlZjNEpMZmxxNEcybUJzeG9vTDAv?=
 =?utf-8?B?RWQ0YXd4WEpIeXZ1NUZDQ00yRGlCVzFpNkVSU040Z3BNVE1iRHNuV25GTUNu?=
 =?utf-8?B?M3RWL3VSNVpEWDRvOGF0R3o4RUhkTml6RHJ4dmE2QmNIRmdMbWF0UHJBOWFx?=
 =?utf-8?B?eHBVbWU4UE5VY3VtTUYwMURDMkJnMjVkcXU4ZkRqUDZtM1lSTENhcitTclp5?=
 =?utf-8?B?TnpWTTlFcHh5SXNkUnBPL01NOGpJUFkvd1hiT1djNjNndXQ1MGJ5WW5kcjNN?=
 =?utf-8?B?b0hlSGRSSS8vQjBnR2RrY1lLY1RWVFZYd2hHWlU2OGpQQ3J6bnlZQXpObjVY?=
 =?utf-8?B?ZVg1eUw2d0RMTWpMbVBaSGZxM0luQ1A2VzY0ZzZrMVhuaUZFL3I0cG16SHdF?=
 =?utf-8?B?Ry8rVGFwTXd0bVNvbkNVTGo1eDBqc3R1bWErSzNYdmpsRUM1VkliS08vOVEz?=
 =?utf-8?B?UzJvWnlQNWRUc0lrZFhabTVEU1BjdUhrc0ttdnY2M2xNR0d5QjF3UU42bjkw?=
 =?utf-8?B?eFExYXMrUkdlcE5XSXRzSUFsbS9BYUtrOEZqU2JoKzlQd25OTGJodDIrVkEw?=
 =?utf-8?B?dy9mb1hZVmZOVmJRajd6ZVIweklhZUN5a3BiWWFSUGhZRy92WC9Qdlo5UGp0?=
 =?utf-8?Q?P8jJq3z96tmzn4xeOPjbiv7AVvp4J6Dh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2xRRE10a09CTzIvRCtpUEtqYkpvdFgvVmZncWl4S3lLeTJhT293bVRvYU5n?=
 =?utf-8?B?SWdMbmlWY2h5VWd0ZlpXeG5TZHF1RzdXeWg4UWJMWTBUcHRNRUFvT094SWtO?=
 =?utf-8?B?RmdaL3M4ekdWenQ2WmgvV0Q3MktVVFF0NGxvSm56a2lkQ2pGcFdEdGhrQysz?=
 =?utf-8?B?VjF4VzV0R1VEOWdHZ1NpcEFrUFdzTVBtLzJDMWNuVFltblJKajRwWjdxTGFB?=
 =?utf-8?B?QnlXS3RieXhhRkVINGt3d0tSSkFQWjRWR0JJTVVKMWJsN2FBTjJ3L0JhTWJZ?=
 =?utf-8?B?dFduTysvWXZvanNyeHZiWUlHWnZOSEZGaDBXUzNYZVlJK3hPMVlQcDMyenNH?=
 =?utf-8?B?ejgwRnBIemVkU2xaai9CNmxwVDdSck40emQxL1JQTzFlOE5yc1ZiYmFLUCs4?=
 =?utf-8?B?cWpnTit6V2c1bmlsVCtqZ1ZuTjlORjFMVDBsUlE2N2J1dkJGWkhvblN4SWZr?=
 =?utf-8?B?Z1hPU3dWN2RNK2htUmMzU0YzNTMzbm5TaE5IU2d3V2lZS0hVa21KZHZXcUNq?=
 =?utf-8?B?dnZpMnMwRXNldzUwcjdCTjRhaHA4SjE2aDhQaGM3bm1kaDJsZk11UHRzbC9W?=
 =?utf-8?B?OXFKQ01LSDl0YkVEUVp1NjdMT2NWeG5adCtFY21wMTZZWHdGbEh5NmxEMnZm?=
 =?utf-8?B?Y0xTKzBlK3lWU1FZNXFYaWpFY1prK1pmU2ZWTWVwVGtuakRaazBxRVNYM282?=
 =?utf-8?B?NEVLOHl5U2R4aEJKaHVNNURTZlQ3SUcrbXQwVGJzcGtIRGtwNW1tSzJaWjhK?=
 =?utf-8?B?a0lsVC9ITFRMVjFXNjJFWDdXSzVLdG1GYTZhVnJxN2pLZEFzcmNoOGttcGVn?=
 =?utf-8?B?bWIyQTIzNTlseXlFWDFLNkZnQmhMZTBRSkZiUWQ4MldkZ1JDaERIbC9nYXJM?=
 =?utf-8?B?SU96eVFvMm5nTlZuMFhtbWNEOFI1THlTbGNaTXVaTXFwSEt1MVhqSWdSSG92?=
 =?utf-8?B?aFdTdWxCanYrSHE0cnlSRTFvRlZQaVdsb2ZFLzFmcUNCaldLR0wxQ3pwYjF5?=
 =?utf-8?B?eXNjeEIyQVhFUXVRa203TUk1a1hrSTFWRTMwV0JGVFp4dGI3VVlIRHRuaXZ3?=
 =?utf-8?B?NDJDTTRBQ3F1bVdBOTkydFBtL3gxZGh4VHRVZE5Iem00ZGd3QUVieVg4dUJY?=
 =?utf-8?B?UytmUWhaUUlDckFEUlkzMnBWZFdqY1d6MzE3blV2QnpLZHh4RlBEdW1YK3Jz?=
 =?utf-8?B?S0lQQThYNVZzMDVtUUZGMVk4QzJ1MEZtT3N2Tkgyayt1dC9CSUZHWUh2T3Va?=
 =?utf-8?B?Q1F0Z1M0M01UVUhDQ3dySy9xRUFCZGpuajNqdWNkeFlsVGhDTWFkTFBteW5u?=
 =?utf-8?B?MlVSSUU5dGxhNHJiL0Z3akxHRE1vY0RpWS9UdURULzlpWVpQOWFvaTBoU3lU?=
 =?utf-8?B?YXVYUHFOTmVjUkVDTXBNQzVFaCswcjBMcnBXa0NIZ3ovOFpIbjFUaGhsR0xW?=
 =?utf-8?B?aWozM2toRkhrMG1ZTFl0L3pTVnZqM0tLbml0LytPTUFjSkVJckYxZFhIMmtx?=
 =?utf-8?B?bm9TQS9JSTZya2dkZEJvWHVCZ3FnZG11ay9pMENCZlVya0hoZDEzYy94SDdK?=
 =?utf-8?B?Rm5xeVJVK3BzQ1RHOTU5QzY4dU5UZWxYQWJlcURvbTVYTEJEcnhqVm84SXlt?=
 =?utf-8?B?UWZ5K28xVisxbDI1UHpjS3NidW5sWEdmVHQ3ckRrSi9INXh1a3FiSGZ2bm1w?=
 =?utf-8?B?aDZqcGNRM0dCS05LbzYyWHQ2b0RjWTN1b09SUE8xK2tZYVVDYlN0TVptckJU?=
 =?utf-8?B?dDVyQmJvdUhTNWlXTFZpS0RZNGpVbTluTXh6dDU5QWttc1pJUlhEbjdlT1RW?=
 =?utf-8?B?VXRyQU5nT3FsL1lqRVJhWit0bDg5YnVzU2szSjlWdWwrOFFOb1hDOFk2dzF4?=
 =?utf-8?B?eHh6bmNMRmFMS29iWlJwZTE0NFhNTHpheTRBQ0VuYlBMbkYvNW5STmRodXBZ?=
 =?utf-8?B?Zy9zZk0yZ2RqVUpTVFFiWGRCSE9yaVBkbU04OGt4aFcyeHRpK0QxVUtvRTdm?=
 =?utf-8?B?cmJXMzE4Q2prdFdnNk9heExiY0hDTWY3U1hlQmxKU1loY2Z5V21hU1VlU1FJ?=
 =?utf-8?B?anRRMTdPYUJhOVZmbjFCeUNOcEFOVWRUN3VDUjJPeFF2a0VXWktpWnUwMi9x?=
 =?utf-8?Q?7mhpHODCISuSVBG8R404OVaSn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e8aac-3ef2-4fcc-7e9b-08dd4fe777fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 06:42:52.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfAFBP+LHVTgkvmCkbjRralLin/4cX6g8da9eatf+LN7rLW9u7MB6abaNUFy9QMYjsCLghS5iEAEpWTdjjo0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAxMi8xNl0geDg2L21jZTogVW5pZnkgQU1E
IFRIUiBoYW5kbGVyIHdpdGggTUNBIFBvbGxpbmcNCj4gDQo+IEFNRCBzeXN0ZW1zIG9wdGlvbmFs
bHkgc3VwcG9ydCBhbiBNQ0EgdGhyZXNob2xkaW5nIGludGVycnVwdC4gVGhlIGludGVycnVwdA0K
PiBzaG91bGQgYmUgdXNlZCBhcyBhbm90aGVyIHNpZ25hbCB0byB0cmlnZ2VyIE1DQSBwb2xsaW5n
LiBUaGlzIGlzIHNpbWlsYXIgdG8gaG93DQo+IHRoZSBJbnRlbCBDb3JyZWN0ZWQgTWFjaGluZSBD
aGVjayBpbnRlcnJ1cHQgKENNQ0kpIGlzIGhhbmRsZWQuDQo+IA0KPiBBTUQgTUNBIHRocmVzaG9s
ZGluZyBpcyBtYW5hZ2VkIHVzaW5nIHRoZSBNQ0FfTUlTQyByZWdpc3RlcnMgd2l0aGluIGFuDQo+
IE1DQSBiYW5rLiBUaGUgT1Mgd2lsbCBuZWVkIHRvIG1vZGlmeSB0aGUgaGFyZHdhcmUgZXJyb3Ig
Y291bnQgZmllbGQgaW4gb3JkZXINCj4gdG8gcmVzZXQgdGhlIHRocmVzaG9sZCBsaW1pdCBhbmQg
cmVhcm0gdGhlIGludGVycnVwdC4gTWFuYWdlbWVudCBvZiB0aGUNCj4gTUNBX01JU0MgcmVnaXN0
ZXIgc2hvdWxkIGJlIGRvbmUgYXMgYSBmb2xsb3cgdXAgdG8gdGhlIGJhc2ljIE1DQSBwb2xsaW5n
DQoNCnMvZm9sbG93IHVwL2ZvbGxvdy11cA0KDQo+IGZsb3cuIEl0IHNob3VsZCBub3QgYmUgdGhl
IG1haW4gZm9jdXMgb2YgdGhlIGludGVycnVwdCBoYW5kbGVyLg0KPiANCj4gRnVydGhlcm1vcmUs
IGZ1dHVyZSBzeXN0ZW1zIHdpbGwgaGF2ZSB0aGUgYWJpbGl0eSB0byBzZW5kIGFuIE1DQQ0KPiB0
aHJlc2hvbGRpbmcgaW50ZXJydXB0IHRvIHRoZSBPUyBldmVuIHdoZW4gdGhlIE9TIGRvZXMgbm90
IG1hbmFnZSB0aGUNCj4gZmVhdHVyZSwgaS5lLiBNQ0FfTUlTQyByZWdpc3RlcnMgYXJlIFJlYWQt
YXMtWmVyby9Mb2NrZWQuDQo+IA0KPiBDYWxsIHRoZSBjb21tb24gTUNBIHBvbGxpbmcgZnVuY3Rp
b24gd2hlbiBoYW5kbGluZyB0aGUgTUNBIHRocmVzaG9sZGluZw0KPiBpbnRlcnJ1cHQuIFRoaXMg
d2lsbCBhbGxvdyB0aGUgT1MgdG8gZmluZCBhbnkgdmFsaWQgZXJyb3JzIHdoZXRoZXIgb3Igbm90
IHRoZQ0KPiBNQ0EgdGhyZXNob2xkaW5nIGZlYXR1cmUgaXMgT1MtbWFuYWdlZC4gQWxzbywgdGhp
cyBhbGxvd3MgdGhlIGNvbW1vbiBNQ0ENCj4gcG9sbGluZyBvcHRpb25zIGFuZCBrZXJuZWwgcGFy
YW1ldGVycyB0byBhcHBseSB0byBBTUQgc3lzdGVtcy4NCj4gDQo+IEFkZCBhIGNhbGxiYWNrIHRv
IHRoZSBNQ0EgcG9sbGluZyBmdW5jdGlvbiB0byBjaGVjayBhbmQgcmVzZXQgYW55IHRocmVzaG9s
ZA0KPiBibG9ja3MgdGhhdCBoYXZlIHJlYWNoZWQgdGhlaXIgdGhyZXNob2xkIGxpbWl0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0K
DQpSZXZpZXdlZC1ieTogUWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQoNCg==

