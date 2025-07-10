Return-Path: <linux-edac+bounces-4340-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86683B000AF
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jul 2025 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622EF189EA01
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jul 2025 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344623B61B;
	Thu, 10 Jul 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ca/LMCMA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C903187554;
	Thu, 10 Jul 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147556; cv=fail; b=Ea80sjnxPKidXi6qdotwGeOqYSgj3u7K7QXyxB/GIU7wHAGBTAawuOjG5scZp0e6eZvqsBjzAHfoQTDXCAasyS296HoiRpbD3rr5nbv/KWrJRKc4xVvwy/dyvx0I/kSowEXxuvyIvCSzHt6JKHq6jRI5qZKx6hDVU22+3ACTwOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147556; c=relaxed/simple;
	bh=aX/KwGu86qqnnPZ18nzBFbHuQN/5M+JHIegTn7YH5PQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKODr5ibXpW0wU/uMCEqxzaRDWoFoJ+neP2LRceT67whrwsgEF7io/KVWqFjfL3kJ1OVInmFl6ZnvU85YUK7xkVQf5SF/L6uLf2y+clrP12NjX4adZYz9hAnT9jkJPVOPEzeKFrBj5q/SSjKONwj0DozefYsykJ5zfHRfT2REH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ca/LMCMA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752147544; x=1783683544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aX/KwGu86qqnnPZ18nzBFbHuQN/5M+JHIegTn7YH5PQ=;
  b=ca/LMCMAQo4omg6QnRMkgz/UjBjvxGftdnuVJ6xdNrpZxHdbwtrglza6
   5vlWSK+j2lAhG+8XEWN/c8FN7G6zuqPpdBfTx/EoO6kd+qya8r4aIBZY2
   VFcKwpQa3ZI3u4ciT9i9iMDLVOAIXolv+HsHGrBzUqyQR86XBGjLZ6N4z
   iDVOpg+HUmKmgLLqfk9PiZb2DS6MEicpanhPaUn3KUbJz8Fn+zsLGKj6Q
   e4c2q0LMZTWupscRX9iOtT9Vr/579j8deg1muXCd/lM7pEsugLqcxI4zd
   77vI9P5jE1f6zhNn+GDUfd9VjHPmlcyBDpK7scoaxMt9hWAEkFt+CMAh9
   g==;
X-CSE-ConnectionGUID: b+IIafAqR3CX7qp3IQGxpA==
X-CSE-MsgGUID: W8jiQtDzTl+f1HYxoWmAug==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54573703"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54573703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:39:03 -0700
X-CSE-ConnectionGUID: LPvi9AGjSH2ephI+Kmg/9A==
X-CSE-MsgGUID: 4brCfcsDTa2U4vggzo50Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160343339"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:39:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 04:39:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 04:39:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 04:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNk5KdACNaxSmpQynMIApBXro3VvML7ye9rwXOZUhnqoVm624slcNmUoewqT73u4jIa1ogaN87Z5wYUTuFogJR/AxoaW7kvqBRoyWim/i7/jHRSgQJFiTuX6UtYbXd2e0iNuoJMcN6rdCn5Z9Id6fxPstdYt+k+XAaOVcDBfKMfzNNYmRNgkUU3bjwFX9bELmBqQwfjKAuQyGVZnrDGvUaA5EEofjNSW2vThJY9kjNGXNftSe6+fxtQxGcgHC6Yl3bgoFrmAn9KJVPDTjQvPd6aGmklqKDqXGQtgpjIs0S69JFb5HainlOSz/bgeX2Vk+QM8K0aiyGuvqkMfdb78WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX/KwGu86qqnnPZ18nzBFbHuQN/5M+JHIegTn7YH5PQ=;
 b=gWXzBiXZXuJ83jI9DrqV3dqvZ+2SxQyFGQ9hsi63oX7rniMnctPLPjyLjq/lIANyZedESTE8U54PCTwzujSjSwJ8msYdynVYzsqFClivxAEUoKV7KEe25uf4RqgKyA5fiBLJS1ic+Vd3SQj4h3KK3cAtW7PCEA49Qv79lA8vRvuv/q6EWK8OCA8e2oVnohiT1yIQ1WsHuMgQAjnHTtvlylWQTsKWelQSmNQLMyjQL3Fzap9j67K1oYiZLPijIEuYylstTgtzQ35fVRDBK32x272q8uehpYKGNeJjqNj40bFWrwTg4R7N/u6npfyMTVa0bOwYVtyCzi4RXJ6ncMTnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 10 Jul
 2025 11:39:00 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8880.027; Thu, 10 Jul 2025
 11:38:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: We found a bug in skx_common.c for the latest linux
Thread-Topic: We found a bug in skx_common.c for the latest linux
Thread-Index: AQHb8UCXLp35SLv4qESMGHAJHYuEdbQrOvQw
Date: Thu, 10 Jul 2025 11:38:59 +0000
Message-ID: <CY8PR11MB71349230AB9CF3347D333AC48948A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
In-Reply-To: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV3PR11MB8602:EE_
x-ms-office365-filtering-correlation-id: bf4d2669-ef31-4ff1-61ad-08ddbfa65cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L0lUZG9CaHBSOUgvck1NaW56aUU0OUo2UGczR09DU3A2V2wrUDlJTGwyRnM3?=
 =?utf-8?B?ZndidStNWFd5MG1sQjZLNFVkU3ZQeGorQ1pBeHJKeSt3NWJhVVhXUS9ONFI2?=
 =?utf-8?B?SmxwWHRLNXRMMkpvWElSeVpVOU0reFNJU1c0WlkyOUp4Ny9MRjVVQXVPYmpF?=
 =?utf-8?B?SjBvaW55ZTY4VXJOSzRadSt3NEtoQUZObVlmOXRtaHRBeTMyeUtrR0VRK0VW?=
 =?utf-8?B?azFKbXZrb2pIbllPcGxzdEMyTC9IcDVCcUREbldrOVIyVSs5NXJ0VjJIV1lS?=
 =?utf-8?B?MHRrUXFlMnZIM0ZSYkVBTmZ6bVpralVLaDQzdGNmaEhTTURLaWM4NkFUcURq?=
 =?utf-8?B?ZHArM3ljNEVkbWRHalZuM1J2SzhrdCtHYmdEVFpzSEJUUDhlcHlzeFBpYzM0?=
 =?utf-8?B?VjFzbHR2OGxIOTJRQ1k5ZnRKQUNBSnl2clE1SnozR1hlcjB1WFFmRFBaYkRo?=
 =?utf-8?B?SytOM0VEMGZ3MUo0UE1Uc2tobVN2K0NJNDNpTnFkc1NrSXpRSkhSQ292blA2?=
 =?utf-8?B?Q05iM2NsZUREbm1pWjFzSHY1V0JRL0gwdllHM1BIcVJSQm1saytPZEE3Kzk2?=
 =?utf-8?B?REswM29oenp3ZjQ2Y2ZUK0pyYTRiZkd3U2hNa1VpM2FTWW1tamVXUkl4ckJu?=
 =?utf-8?B?b1kzNitEV0lOalMwem4xQi9YUzBOMisvSXVrbkxqL2w3S3Y4blduY1lYTVF6?=
 =?utf-8?B?ZVNvaWRnOFRDb2ZxWm4zdHgvZTdtVXlSajI5MytnVWU3Sml2V1dJQ1Q5STdC?=
 =?utf-8?B?bERvWHNOMlFlWW12RW5oZytBa2tQckpNWVYvUFgyNjFIUmVXOEllQXVxZDRW?=
 =?utf-8?B?dWpvQUJqYkNjaFJBbTI5cEI2Z29yMUlyNzNEZUFhM3JJNkQvcjJxOGNTZkJy?=
 =?utf-8?B?aXcwRWludlRCeDV4bmduV1o5dFpRTlBxZFh1YVFtL2xteWFQQ0YwZURFamNY?=
 =?utf-8?B?MllWQmtxRDhmM21ycmZLN2xxck5UL0FKaDhsdUhFb3I5Z2FOeTRFN1MyOUk1?=
 =?utf-8?B?N2RCVWF0RlJrY1J3eGFpQ3I2WXgwVERoQ3RHRXFhVXhkc2tyN05FMUxwbDE1?=
 =?utf-8?B?RDByUTd2QzBiZEkzZkhRbnlnSjQ5a0FvUXJaeU5HYVBDK3hEOCs2blE2czB5?=
 =?utf-8?B?L2NRclF0TWNEYk5TTDBqdDNHZ3VYNWxVVDFuL2pkMXFtQUN5RFE0WWpGdmRW?=
 =?utf-8?B?c1M0OVVseUwzcytaQnlzUHkycFhUYTg4WmdPNWRna25lR1FDbE1JNDJqU2ho?=
 =?utf-8?B?WDZSd3I1TXpLTEZZV2o5K2pjWS9MN1k0OWVCMlkzQjhOTGs4T2s2OFYrTHlK?=
 =?utf-8?B?cGlTaUoxVTFnVG5jTG9JNi9sekpwdTFJRmhNOFZVWkZuYTUyK29LV1VpMmZH?=
 =?utf-8?B?ZHRvYkZycnI2OXlwYmJIc1hiR1VyOCtlVm45eUk5NzdlKytKV2Fha01EOEJG?=
 =?utf-8?B?OFFuQTBPSnBsN1owTTZoUlZuY2JqbG9tVEU5bStQUGI0VUY1Nlpyc091eUwz?=
 =?utf-8?B?cDFwUEJ0WmQ5UGd2eEwxdUFmTkRXa1JMUlBQUy8xSWpHendZK0M3MzNCRmFt?=
 =?utf-8?B?M2IxbllRM1RBTURmUVVvaW8yVGNOSEdaYVhpNmR6TXJXby9HOE9MUGh4WGNV?=
 =?utf-8?B?dHdnd2pUb05mdmJQVUlVRDMzZGFtaVFLYVJVTzJSeHRwSWRzUGU4cUZJbktm?=
 =?utf-8?B?WjNPb0hTNEtleElDdnUrUngrdzJ2a2U3dE5TVFhpNFVQenFKZ0RhNGQ5QkNt?=
 =?utf-8?B?T2E0VmFiaWVUbzVZdUd6UFJwbzNIKyt0MHBHSWRzQm5sUk5yRUtDdXIxYnhD?=
 =?utf-8?B?dC8vL3JERXcyOStMcnZYbHIyZUtJQVVQV1FYOHpKdGUyaklUNW9QN2cvUThW?=
 =?utf-8?B?TFdPZis5d3BpWHBleUY4MUIxUGQ1aXhMbmJ1Ulk2cExLVG04OWx1dDdKNDh5?=
 =?utf-8?B?N2FzOVhCZC9IZ2JId0NBSWNvZ3pCb0ZnSHUvSUR4S0JQQzJRdkoyUUsrejlz?=
 =?utf-8?B?UHlva1pGUFJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDNIUjA1cFFsL2QydGV2V284eERUT1RKUzU2OUp4bVIwc3R1clEyN3ZMRHZr?=
 =?utf-8?B?Nm5IeUJJWnM4SE8rb29GZUFtN2JlY3kvSXIxdThXWWlFSGpOVlJUS2tsaDAy?=
 =?utf-8?B?bWxtdnBxM1hEaGNsa0JNdnIzVVRFN1pDQmVRQ1VXNHo4MjNqWWNxY0hqTjFq?=
 =?utf-8?B?dWpyQkRJSWVueGZlNDdMejhLbVZvSG91S2dQVElXdHI2cjdRNmNyK2FBM3pi?=
 =?utf-8?B?UWpIVDdPRWpuNFA5T2RvM0hIbUFGbTNxN082Y0h6Z2Q1WjhIQXhtZE0xZHlt?=
 =?utf-8?B?Z01uSllDS3NrSWpIYldsRSswOGh6WGpZYVNBNmRXZFlXVjYzcXdFOVdvek9N?=
 =?utf-8?B?ckpNRDZJRnZDRWVjbkFVNnp0dWcwSDY4ZUl1VkRTZjBseEdHQ0gvMGhtYldP?=
 =?utf-8?B?L1RGRE43Qmo4Vis2SFJ4Nkcwdk9ETm1IWHBuVkxpd2JGdUI3bHgxeUgyU0Rs?=
 =?utf-8?B?Zi8xcm9LdUdpb096Y0I4MXFwcWhJeEhlMFljUHU1UzF2UnFOTGpCeE1IWm9O?=
 =?utf-8?B?ZEt3dndCbU1xYjZpTzF5c0tQOERDdUMrOElXQnlyRmhFN0lKVWkvWWU1NE81?=
 =?utf-8?B?QkMvN0p5dDZXVHN1ZkhRL2hMaUUyZnFLcGE1RUlJLzN0WDhNVmY5eTJNVDhy?=
 =?utf-8?B?cjdaWFRkSEtPYm5RSXFUcWRkRzgwZlkzSWZEbElKNENLZTR0N2JxMVFWSHBG?=
 =?utf-8?B?Qm01aHEwTHYvbzI2Sm9PSHJSTkRjVGVwczVEdHROeVRPWDArNEkzRWJaQ2xs?=
 =?utf-8?B?eUd2WTZwK3NKaG5CM3FLbU1FNDQ0Y2xybXdQcFhHV2lOc3ZKMlV0V2RBL2Ro?=
 =?utf-8?B?QksvZkZPUFVIdW5PZHJRY0FMUTU5TXZ2WTN2U25RaDA3MGErdUZDMHpkVnRD?=
 =?utf-8?B?Tkt3bVd0VjVINC9pMzhlOHgvV25XNElWWUZtdE1FdjNBZkJKOENnMHczaDVo?=
 =?utf-8?B?N2FTMU9sWVNFNnpYelRQek5nVDVyd0Ivalc1cjF1T1Z6eSt0cjRJRmpjWGdt?=
 =?utf-8?B?YnFKRlJBVkoyL3RESU1Ub2s3OERvOFhQTVNSbHBvb2R5azY3SkFyYWN1elVD?=
 =?utf-8?B?dzdxejVac1lJcEU2QW15YU8yTlN2Wk1oL3dZbmVkYU1qQm05ZVBCYVRCaVlm?=
 =?utf-8?B?ZlRIM25Yd3hGQnhTd2MyQ0FHUjVzMW42WGtjb2VWSjREeDBjSkJOODJRS0ky?=
 =?utf-8?B?TndkeUdKN25iZGJXNHpld3FWaEN6bUJ5Q2RONVBwQUFydjRGYjFHekxjdzZF?=
 =?utf-8?B?RmIyVlByL0p4QjI4SlluUzFGaStkN3JOb1FLVEdtKzJmbXJrbnRsUmRaWEZ0?=
 =?utf-8?B?aU9RQVhyWU1uOGNWWUIrN3FSZHJyNnZ1REpXeXg0Sm1XbUd6T1lVbFlVTW9V?=
 =?utf-8?B?WGlNR0tla0FqWkNJWGpWTFIrd3lOSXRlNmRZbmJjWk1XOEd0T0x1NkVFbmlY?=
 =?utf-8?B?aHM0QjZiWWVVM1FnWXdPb3ZhZHZQd2J3T3YrY2JDVC9ob3JyY0dnV2krZEZQ?=
 =?utf-8?B?bDBmU2tCM1p6ZVFxWURQaFpWU1pkd3ZuVXdZNFdGeG5KYTAvVHJuanY3bE9S?=
 =?utf-8?B?WExRT1lJM09LNS9ZMlg1TEZFOGFhTWRwYk5NUC92R1VHMmNPYmkvcGhUYmJh?=
 =?utf-8?B?UmQ5YzRCb3ZpTVFzNEgxUzJabE5ENlM5d0RXbjRXTm9iZkZOQk1rRVFrblk0?=
 =?utf-8?B?VGxEaXpoSk14RzBCdWlJbERKbDRmZS84TnZRTDREcHNTd0dZdVFWV2ZhVDYw?=
 =?utf-8?B?L0x4VjlZR0sxa2gvRUQvUFpoNmFncFlhWnN2Z21aN1FEZUE5Nm1ML1gxWUNz?=
 =?utf-8?B?bVk1d2cwZ1ZnQUd4UjBhV2t2L0VVZ0dNZmF0WkpIZzcyWGt0OCtOcG5ZRW9F?=
 =?utf-8?B?Si9kRXIxYTZ5QzNpVDlGWWw3WnJBa3JaWG1GQUVWdWQ4THZKQldNYW5MWXAw?=
 =?utf-8?B?SmdnQ3JnbitpSGtiazBrWHppNStiNnozYy9Qc0ZqWmIzRWFvVjF0alpOdlYr?=
 =?utf-8?B?c2RHcEpyeVpWdm50TWJOVVFlVTB4cmsxdldtV1p1RGRrdFFYN3ZlUjlrNFlH?=
 =?utf-8?B?dzUxYzdEaUlCam94S2VGZ1U0MHJTSHpFMzdETFhRMkxnWlJaeGFkUmI1RTd4?=
 =?utf-8?Q?nKFtNMOhkbg/i/1eURSzdwDoY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d2669-ef31-4ff1-61ad-08ddbfa65cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 11:38:59.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwSCYRtVg8koJVWJk2RTffRr9nYWajFdDrVK/tyLjxiUCbXoNRAGbgN02Z/tDvuJfXkp/sRSeOh0G5F3UDXlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-OriginatorOrg: intel.com

SGkgSGFvcmFuLA0KDQo+IEZyb206IFdhbmcgSGFvcmFuIDxoYW9yYW53YW5nc2VjQGdtYWlsLmNv
bT4NCj4gWy4uLl0NCj4gU3ViamVjdDogV2UgZm91bmQgYSBidWcgaW4gc2t4X2NvbW1vbi5jIGZv
ciB0aGUgbGF0ZXN0IGxpbnV4DQo+IA0KPiBIaSwgbXkgbmFtZSBpcyBXYW5nIEhhb3Jhbi4gV2Ug
Zm91bmQgYSBidWcgaW4gdGhlIHNreF9tY2Vfb3V0cHV0X2Vycm9yDQo+IGZ1bmN0aW9uIGxvY2F0
ZWQgaW4gZHJpdmVycy9lZGFjL3NreF9jb21tb24uYyBpbiB0aGUgbGF0ZXN0IExpbnV4IGtlcm5l
bA0KPiAodmVyc2lvbiA2LjE1LjUpLg0KPiBUaGUgaXNzdWUgYXJpc2VzIGZyb20gdGhlIHVzZSBv
ZiBzbnByaW50ZiB0byB3cml0ZSBpbnRvIHRoZSBidWZmZXIgc2t4X21zZywNCj4gd2hpY2ggaXMg
YWxsb2NhdGVkIHdpdGggc2l6ZSBNU0dfU0laRS5UaGUgZnVuY3Rpb24gZm9ybWF0cyBtdWx0aXBs
ZSBzdHJpbmdzDQo+IGludG8gc2t4X21zZywgaW5jbHVkaW5nIHRoZSBkeW5hbWljYWxseSBnZW5l
cmF0ZWQgYWR4bF9tc2csIHdoaWNoIGlzIGFsc28NCj4gYWxsb2NhdGVkIHdpdGggTVNHX1NJWkUu
IFdoZW4gY29tYmluZWQgd2l0aCB0aGUgZm9ybWF0IHN0cmluZyAiJXMlcw0KPiBlcnJfY29kZTow
eCUwNHg6MHglMDR4ICVzIiwgdGhlIHRvdGFsIG91dHB1dCBsZW5ndGggbWF5IGV4Y2VlZCBNU0df
U0laRS4NCj4gQXMgYSByZXN1bHQsIHRoZSByZXR1cm4gdmFsdWUgb2Ygc25wcmludGYgbWF5IGJl
IGdyZWF0ZXIgdGhhbiB0aGUgYWN0dWFsIGJ1ZmZlcg0KPiBzaXplLCB3aGljaCBjYW4gbGVhZCB0
byB0cnVuY2F0aW9uIGlzc3VlcyBvciBjYXVzZSB0aGUNCj4gc2t4X3Nob3dfcmV0cnlfcmRfZXJy
X2xvZygpIGZ1bmN0aW9uIHRvIGZhaWwgdW5leHBlY3RlZGx5Lg0KDQpEbyB5b3UgaGF2ZSBhIGRt
ZXNnIGxvZyBmb3IgdGhlICppc3N1ZSogeW91IGRlc2NyaWJlZCBoZXJlPw0KDQpUaGFua3MNCi1R
aXV4dQ0K

