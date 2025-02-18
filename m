Return-Path: <linux-edac+bounces-3141-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482FDA3A30B
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 17:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1390A1671D0
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3158D24336D;
	Tue, 18 Feb 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS9KJZQ8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282A14A4E7;
	Tue, 18 Feb 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896854; cv=fail; b=ec10QosFnReUcrFpaqSR8yohNhMav13JBeJOXuklR61A8j9XghHttHchBl4QO/m2ViOktYeb6AWmcQFwf4Z2RWabIrTuMvZQRr5IquuE2zhEBoUDAKYmCrRpI/Mc+/eJsqm4LM6Wamua+PIw8X8a69xjLaRSGDpUO4yXcyYRvsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896854; c=relaxed/simple;
	bh=uQFW2TgESfQy3S0Fb5dG4guF1scWUjr3Z5FhLXlguxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pz//Jmg8y03Z2lOXHUBgdxV6XpR0RK9NUra+p2ANp76QzZYX+feyxGOxbiFFEx36DXl9CRxiVACo/kr2GOmnwE9ZV+GwIjlnci5L10UJNRwbmblnvomcKLThdLQZhQQ8o9JZLzMzE3Gh2RK2oteKZGkRjc2haEbE+O3256ODqp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS9KJZQ8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739896852; x=1771432852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uQFW2TgESfQy3S0Fb5dG4guF1scWUjr3Z5FhLXlguxA=;
  b=LS9KJZQ8x0WaZTYSQr8AVO77OMoJsPlJknc8m08gtSr394K47tiEuXdG
   sXRHdxfyE7JKZ7VqhewSPIHWkE5MruscxVG1sMBpWj+4+Ntg0jludr9aj
   KMVLDDxupxIxIKaKUpQRU/PoyZ4UL5dF6DCjjLZvrmYU5O47A9tC9ZIR/
   dtxyNqv+ldQlZz4SW1m0SObwZPUHrve58iOlYFWSrhuyTRffCdikrFGmw
   FIgmAsSKCcENj0PBZLDoFQngTGgZuaKniV3e03obIgE2yCDz11TNx3ttq
   q38VpXAJ89eRL4q3qXtlTm89k3zHRZPNsr5AUq399qtp5mO8yQVGvfga/
   g==;
X-CSE-ConnectionGUID: bNw70AlaT0GtoZaELPAWlQ==
X-CSE-MsgGUID: rUq13a86Tt6kiXscwqFt5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51223175"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51223175"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 08:40:51 -0800
X-CSE-ConnectionGUID: xVUAaAGrSmC07wmuLfGrtA==
X-CSE-MsgGUID: r+UhJO5qR42HBV5kD/L5Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="151661966"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 08:40:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 08:40:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:40:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:40:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJxrz/vI3NV4ijyBIEXy+dUbiRhUtKPxjvg/EKmdJpAljbM2UuXZ/jQuf8G0BfW+yW6VRGAhdc354Ka/Vhl2sybWQYtzSats5wxU2/QDMgYnHHXIapV3C7JYye7EKQf30MSbRWCmgZgSDvPw93lZR48pKAftGWQyjM4CqUAXQDxgdVzGxYZykCrI7bF3eJnKSI3WDcBhrIZjvpTY2BWeqZK7qFjGbzcv505kZieXXngj1ZyvOVRQ0Y67R6KtOU5ea9YRGcuDmXfImpWTDXlJAKlxEIVrQ8J7MpJr4uOBtrClAdK4qEVGVuvyEPZtAHmS0xIsA9P+kjYdG/4WufLL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQFW2TgESfQy3S0Fb5dG4guF1scWUjr3Z5FhLXlguxA=;
 b=N0TGwLidXr80LJu0vr9jz044UBvFLrJStcVYcx5E0TiU1liGsZDPEQNaCN2ygVBEEKaJoY2TUVR74Z2pCe+BZMcNKRau375fQzxO5CyLNVKlHk7zcrJSUE4RJN+r3f7WDQZz4UT5ll48t2ApRWhg/IfUmG/5GTjJYzWzvPvSgSZPbbPJ0sevZFt+yNoOh7ZwJzGVPv8O+nXFb7sBNx3ZQ4Un9tPD6EUiwO/mB0Aivpt2oiKGzqYsnUfKTzFCyxw3up16dqqatLlQNTAdEQ97bw2MMqpiVWSR+6tAX3ZMhs1tITsynXNwgNZrvrsGlTmjSKq7Ub+snOCz8v7lYTkqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:40:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:40:48 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Thread-Topic: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Thread-Index: AQHbfjbuLx1rE9/LwUK+REVwY67N0bNLiudIgAHAHMA=
Date: Tue, 18 Feb 2025 16:40:47 +0000
Message-ID: <SJ1PR11MB6083A66548956BC3AB47533BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>
 <Z65y-1IQKmCLOhXu@agluck-desk3> <20250217135534.GA591070@yaz-khff2.amd.com>
In-Reply-To: <20250217135534.GA591070@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM6PR11MB4563:EE_
x-ms-office365-filtering-correlation-id: 450e6df4-0bdc-48be-e769-08dd503aff52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZOLxQ2VhoXLUbBVzrsJcLNP9Tb5IAtRzOqHh0EetLgDvuhLXYJtZWa5HaTCo?=
 =?us-ascii?Q?kad3H2BfQfgs2txQp2M8k7W8H4sHPTxakXPKIJog5HyjC6DOU3DO7VaP6Vr6?=
 =?us-ascii?Q?sVT1FbukrRscXvUMZl6F3MBO/5+EFkRX3Tge9igOrw+68nS1CwQ309hIPa8M?=
 =?us-ascii?Q?XE4ZMhol7KVcEsFysBILLVZfPw3de61Nx5HaCCWW7L8RjAvwDtzK9McQQ/LF?=
 =?us-ascii?Q?D2fENJ6Yzl6h0BV04MsW/7MgNEBGJfqWZ6fPmNfhykbVY59UhYJ/J79j1i49?=
 =?us-ascii?Q?utmuZx+3Yst7KjxIi3DmZxyQNLRhruvnZF4eUA2wyQExW7/i++HK08zl/mpG?=
 =?us-ascii?Q?tnDqs9Zd3KVCMQNSZ3fI4uFOeVV+/Kk43Kb6ycMz89SxVvaS7rOnRy0nYjk3?=
 =?us-ascii?Q?l8eQj55yHX7PhnptXfcm+JGzwAmdTB5CtGoDPmrF/4Mf6I81/Fk6RPvJHlk0?=
 =?us-ascii?Q?wT6OCq+dz5K/GK88hBkPY7QCE7y3FR00WhXtbqQRyk8Eleo14mhh8BP8Z1Xm?=
 =?us-ascii?Q?58bXp/QBVZf3IrnW3tIDoL8Pu7t/049OdAhpWftkU4ZMj32X46RkVS45QT9u?=
 =?us-ascii?Q?D94B95rjwRQATm6Vbn5WmO6xmWdDNJaqUzuvVf+nGbk4SNF9f7AqTeLaQvCm?=
 =?us-ascii?Q?q/gC1aM7fEwNbyaoc+7Vm4DA+666vK7PYSef/QhaGGH4taWvfjT2Lwyn5dG+?=
 =?us-ascii?Q?QADigkwLDlgz/y/s6DlLMZ0X40qsZgJHFiGdbzNRBHJGSTBzfMNa1Q9C+uBR?=
 =?us-ascii?Q?GwsICevTXZ4qdGI1KIIprn0afI2AjLo9tC6IbrsTm0no8RpBd5lt+sROd5k1?=
 =?us-ascii?Q?YYaHIhqh05IdjNKX4edLeqjpGmfrIdR7rGDXxuJKEOQoIBLVNepoeFgY6WL/?=
 =?us-ascii?Q?kJpDRtakopn0eNmpYV2clE0iYn7uYJLUMIQNtJ6Oye737Y1Qj2MsEygF+Qn6?=
 =?us-ascii?Q?Hfbnobq40hQ8KuKJ2aQHJiSZHjiNZQi4oZRdY9hCJd/RtnugR7DWrQ/y+DPj?=
 =?us-ascii?Q?Mw9rQ6n+XO9iHJU3GngEGi7nwNlrsSzTJYFUmZMl6lLIdxyrBktHrt3485Xi?=
 =?us-ascii?Q?SxaycRo1rcceMeY1CrkGddLCmVPPa81PdSt9LGYuTgAENh0898x0KmuQNdVV?=
 =?us-ascii?Q?Wxril21QHPjES0sb1waKHHlJsf/SxwwJi3S5DGhTy0ibQiZkiWgaO6DyFpw6?=
 =?us-ascii?Q?PAwpmOJdwhmrfn/sQQpFog2n7eVNy4QPBxaY+He5yZ6+8m0jwH8XXVy3B1N0?=
 =?us-ascii?Q?W0yzz1vNcXetIixo7GLEHMIdffRJpogsfPD0/E6nGcgBnOXpKey2yNH2GViB?=
 =?us-ascii?Q?X3oZiU2cwVf1FfhI6e3B9dcnZoU/PpJksRJhL/tPB+zI7wRfEZ7CiE1lCM4v?=
 =?us-ascii?Q?9qi6Ft1UrikWxJkaI/QXKGZu5ytnP7ceRkFrse/1HPgwbmFvAVQ7JfYAt3/O?=
 =?us-ascii?Q?0nU12A21Z6K+nwdfwBzAj4UGCieF8nTz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tpax4Nt/iLFhj4SkIxPT8Ka2JG8LsJ6wagMbWfxbVNOyFJmvcwoquEqXH03Z?=
 =?us-ascii?Q?Kny+ESUi9M0S1wenBCXmm7o+tEYORwb+Ks3Pufqkf+R2Jd1UUniQ4onwAQjS?=
 =?us-ascii?Q?V7kFoHZ1AjkJmV7PDgiwhMmPn+NFX0db1jYtEXUUd71fBVTVdgpitamLK2/8?=
 =?us-ascii?Q?AnYMJVcy6eytb1Sq8ZDxC11ELFiHZbYX7N05XF2De3OJ2X4GMmRTMh0sCIDp?=
 =?us-ascii?Q?/w8eOXcqzzbmq3d/ooqq6hYb4wryzh0IYFoMyQ0dR7fYbIPPnpb09D6h0aat?=
 =?us-ascii?Q?zulFzvxmxid9eww86AcUkN+HdhojRjODh133xIAutEUoqcy214FpeyXLcIg5?=
 =?us-ascii?Q?1oTOKNVi0OVBWz26xLRhI2lBDRP5K7O4rEzscjgWAoEJzzyJXN+ScTfLiNIH?=
 =?us-ascii?Q?4mgDB7Z5ZlipCsg6Z+TzZqzTh5J3mYtV45SIl6lqpLXMSoGvuOQ2DOtF1RAo?=
 =?us-ascii?Q?cBqcG5/3LgwFWksjVNZizEnrzzAcdk5CPj6Vqj5jkzWaxFfxRMm232IChh18?=
 =?us-ascii?Q?8hH2zRCgtDaettcd/5kw3QrO3eF799E//6CG/BAaAbLNPLakZ/Me0QVeQ9oB?=
 =?us-ascii?Q?4nRgDzW+Crar59H/tbnwUuD5TgxeoNzM8h5YXjvkh4wzAwh3fhzxWk1ut4fM?=
 =?us-ascii?Q?4Iu9FuCvgcOAxLWO4HO2oUtKu6lDHE10VffuRb+zTvkb6uaIO+Z+3rjJHeM9?=
 =?us-ascii?Q?xI8jEdMFoIy5iuyHZjDJvVMp1M3WKivoZTioptWCUarGzW4uUs4OCNgd51gi?=
 =?us-ascii?Q?1z+/vo3JbtZW0baSyHBInHoqswMJWy1bOCrAI7fE4EgvVwc33EKSfVyDT3o/?=
 =?us-ascii?Q?Se85ymQs0ySjjirHbl6pjYGV0vuJG/jRzKjSHrWpYbbyv0gM4YMHo8BV2FNv?=
 =?us-ascii?Q?z+02yu8DkYr9jWhzmw6Dl45IOC1aNknuCZD/wwoNuavF3mCh1I8To+WorTO3?=
 =?us-ascii?Q?CE5OXYhTCIMuaICAtF7RdnUARxOVxVc06zAMhEBDMCpD8oaRULyyLrfz8/Ay?=
 =?us-ascii?Q?Hcuu95yJ4fb6lRk8k+WVASqRpqI5RHFdebd37hoqKg8st9Epaq/skLq9PbBM?=
 =?us-ascii?Q?pX9+yAsCjMxlOgbAjUW+G6sTqmxd6QnRAu4KizwZrP+OzZCaf/mN8W033kpE?=
 =?us-ascii?Q?ZPBwNOgGTREitN0bduhAsTc7E8E/UYhug3/LkaHjA5lG1U2TzLgU2CHBh1e0?=
 =?us-ascii?Q?kUGcGaxZLnhk3KcmYrQfXL8RcBbQvlrMKhLiwn/tCDNO92ri7ZgiPvDuLzyt?=
 =?us-ascii?Q?gKmNnKR05NuS29OB3/IzEuqf3k3hbulb8MOUsNhq0OLN45s49nQinvXN0lpA?=
 =?us-ascii?Q?vKMkJQCkVTKjQP2qGGcbUPY+FDebkL5R7saDWH7APil+G2tcN7ukOhPuYa/a?=
 =?us-ascii?Q?jGhS7t0T5fIXzDYkesr64Kw9REccJLTwvndoWzANKMOPSnjRgfl9GKj3MxYd?=
 =?us-ascii?Q?Qnf7S3yQV5+Oainqd4sBIIGu5LEIkMCNYXiBOInsVEJhTrgrFwxF6db3dbtb?=
 =?us-ascii?Q?VT1W0bnTM917MhBK0XzgGcwuqzyfiXbG0/tVrQjIzHlrKrMl4BqpeDP5xbWZ?=
 =?us-ascii?Q?64BFRzHRKnxORwhpW8n6IXKncdMH6uQpykLedfiJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e6df4-0bdc-48be-e769-08dd503aff52
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 16:40:47.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvRDBe58MHiuT44toP0JQddp36K3fGvcYnYzUXbbNHe3xrfO38ytBEFG6ZLi9ub7CD2T72661Tu54woBV4rBFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
X-OriginatorOrg: intel.com

> > MCP_DONTLOG is removed in this patch. But no mention of this change in
> > the commit description.
> >
>
> Yes, good point. How about this?
>
> "The MCP_DONTLOG flag is no longer needed, since the MCA polling
> function is now called only if boot-time logging should be done."

Looks good.

-Tony

