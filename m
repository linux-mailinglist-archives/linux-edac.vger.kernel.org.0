Return-Path: <linux-edac+bounces-4206-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F4AE3374
	for <lists+linux-edac@lfdr.de>; Mon, 23 Jun 2025 03:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2856316EF69
	for <lists+linux-edac@lfdr.de>; Mon, 23 Jun 2025 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7041624F7;
	Mon, 23 Jun 2025 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3OVyIK4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F991DFDE;
	Mon, 23 Jun 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643845; cv=fail; b=Idm0wpj7MMBTa6+nwQHaxE6Vo63L67JpCXS1bbAhKkIoFa95s3IUo8ZfutvuzqrTxcHp6gCErjia3alVXiEN1HijV2wZoK2/Eu52a/dsWhylxAjj2MZjwZ1qP4zz5BWddooH1MRVnnPh2/wSLhghf8kTDOHOg+KQPQhGLQ3w7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643845; c=relaxed/simple;
	bh=JBkFKTKxIUubkXuFJcfRbKm6pRyz2zpIcg2SjPg+ulU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YehymNqrixsSK9YWFZRSEhsiCUy+Kifbwd00vuYqowznGGkDR+Mio0pm/ossiu/VS70N0yCOHNb6e1denh3tQmTiYU9acSg2z4f8X/4kv4WjETRBCPjWn65CMIhzaM6ymjfPcL8gonh1iGlPwQt1knp/tdHFxqOWoN1e8Z/Bcos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3OVyIK4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750643843; x=1782179843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JBkFKTKxIUubkXuFJcfRbKm6pRyz2zpIcg2SjPg+ulU=;
  b=D3OVyIK4OVG1yTYUbeqxXyYKDmVV3azaiQxyj5Dn1o24TGwJlS8wCywE
   DU4g97uo6eUQGJX6Y4uWqnxB7NLq+hR4HtohbG90Z6T5E9QOPz+9BMSG2
   vFMNclgn4VHpPt+yt5KBkoQqh1cIcqaK+gz1n/6+70WLPKWmX6nuzCcbN
   Rly2+RWxM3ggyDZPtoWa4gjSBId6jg/R4a3DPSmUYzYNhPX7S+g2XaCbP
   XaLFsvEkjD7VRu1y62YyfR8QhatiHF08QwT5CoiFNnYNNCIyn4wTKZxBn
   g1RZ2OUgFO17bo7T1DFjb+BmohOMLw9Scll0GvutOLKJU9MzBqH9B2cji
   Q==;
X-CSE-ConnectionGUID: GQ+fPQzNT3yZBjla/wvFEA==
X-CSE-MsgGUID: ZcGF0HZGSm+0Op9xxdyoIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63525228"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="63525228"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:57:17 -0700
X-CSE-ConnectionGUID: pI55hcqyTcq0gRa3SNNQ+w==
X-CSE-MsgGUID: KfdeCmISSkS4sZZyzr0s2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="150870689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:57:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 18:57:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 18:57:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 18:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5wWiqSa3VPPBemC7iUN+kp7uEVGR88C07hiND7iK+cgxLTdueH7mfALJjAevZMgE1OujeBbkuZ4WHFCTBrUn/DH5ujbp7FuEdjSd4gnG4N8wAXaYXLilk8VvY0OqFGgl0+AFrkA6djQb8v1ABOZQ75DGZqTjruQn27v14vfA0M08HRIbqRKSEUy1C0l6ocqRWT7AAwLCFmMbwH7SvDkWu9gnU3OECREEFrsAZSIpWUaVhQ6SshnsVIbzoIZFET42o1L1a4cbouyxiPPUtqRrtRK/RlnCDBIl+G01ahff7RgAbLxaUex1+Lgahh9LB75smSM9vMUS3Flglj9hX371g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee0O+QAS8QGyxezf84RFFFaTRI9idrsGfjRwBByiOZ4=;
 b=aqneHUMz5DVhz28Yo7kAKitAK6xvVILpWqZoIpOYPQz24dwOLMbzOh6F5vIKBGcU2Yx0t+U5I/13q5qKSsXd17VgV3QdL4tXQChIFXUQqsFP5cThqLX85TztZ95JRdroxhUMlYBeuLN27yCPpf587miILdaC9CAXrO+0UB212f46mipKscZrSc/NjjYwGGgl1o7aqkmZMkZn6lvgf/Knl8oKae+hqurS5rQJfGqG5JSW4wCQcFJ+st0ML+miFhr4Stwf0hPP91y5jvDVhuvXMmUsZysU8LG77q1XR19+EQmr+fKd2nP4MSzVTqs0Burmt8A1a62O9ujWhK8kYgwiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 23 Jun
 2025 01:57:08 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 01:57:08 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Abhinav Ananthu <abhinav.ogl@gmail.com>, "bp@alien8.de" <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] edac: Use sysfs_emit_at() in dimmdev_location_show()
Thread-Topic: [PATCH] edac: Use sysfs_emit_at() in dimmdev_location_show()
Thread-Index: AQHb4VgQcKTyBYg1106lf2pwUQ69p7QQAFyQ
Date: Mon, 23 Jun 2025 01:57:07 +0000
Message-ID: <CY8PR11MB7134FEA0D8411C1D319F2C028979A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250619202133.11843-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250619202133.11843-1-abhinav.ogl@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB5216:EE_
x-ms-office365-filtering-correlation-id: a398ee29-d631-45fc-8e0c-08ddb1f942af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NhxBQ8abo1XQh9uNFl74TgAVwD16durnD4Gzd7cbf3Rt0U8kufCyxJ6iEppD?=
 =?us-ascii?Q?TuheENKIAzL4YHneAym63QLVUHLF7RL/xr/+0ENbU1RF+Da3xdHcyri21Hlr?=
 =?us-ascii?Q?cZig96NCMsLqC/kBg0q0ElmlBCcOsXLeK7Yw5BKgqi+elW0FvUV+90QL2jld?=
 =?us-ascii?Q?NwPhcK9hCImph3N7azflZocWfvDGGf44j1tw2wloOgC6lCCUkG3H5Q8StkkA?=
 =?us-ascii?Q?SxwYp/UToFzbrwvOoXnmF9X+6Bc2qxtC4h+RXNIljQ6BemBqHP9ndfqEuvVW?=
 =?us-ascii?Q?c+3OIFNoQe1GHXgKGE0Kb0Z6wM6Z0z3iHevoOVqmqK2w3etEJJqVdfelg9Vn?=
 =?us-ascii?Q?Hru9iVwpVIUS9FqjB8czSOZdjssno1ECfboAMYLfIs8KT6y0/StNta5/zz+X?=
 =?us-ascii?Q?u+hV6i0B7YQQzq/H5ni702spAFprr8nMtliP31A32ERuSaPjuP1U37dCzIFq?=
 =?us-ascii?Q?SP+J2esVuemNKxNaA0XuPijngLBlyunfuSWEwoHSqACOJONh61BonMZD4uxC?=
 =?us-ascii?Q?BNmRqk0rBnhLCpplWH96uFXJ80Ko2crH8eahD2Z8cET38Vl9OzbpPOAk2/5f?=
 =?us-ascii?Q?grD8gf5EHIPr6fYpE/c77K58Ze9JoIPj9tpsvTPQbOX3eam5DlI0pH/b1Dy2?=
 =?us-ascii?Q?hln2ouVTh+ucuZXSXJ4OjqALKaIGmMW1C6zsttmEo/8i/04hy+jKdJKBnzZF?=
 =?us-ascii?Q?n63lYOqk1RNcZDtchFmRoW/cqAVXDZ2Dugtiv2t5SEOtzry/eco/Fv40Ns8U?=
 =?us-ascii?Q?gxXbXv0pfU+AsTj8Em1lr6gyEb/4p7yQVQPf5Ivk9ldw0MaoEZ7X4be7eQA4?=
 =?us-ascii?Q?FJBTPkdq7q+CQFpnU4CXUrmvGkcR0qRvgDl671+8PMvSF91mgCAuJJMhECjz?=
 =?us-ascii?Q?17H3uu6zMO4XZqPYGaX0BhbIyCnkeCrUA0zT9ZUs4CaSQyHUnxiiKlGqA2Bb?=
 =?us-ascii?Q?lBcjBWIoKhxzRhnn1Ort5p9373kzPWpc5Nner2RUjaQgQCVAQP65Bl4RZUJP?=
 =?us-ascii?Q?U6pOKXfrjO4MrXz57lvcespeIr2y4OVPpy1SCXe0Wh7XJLX6QMJdkfbZS6KM?=
 =?us-ascii?Q?WXYNuPy/0j3Vc7GioGJUeaubwp9jXx9lpUiBO9PcWuRc839Jfp0ej2GjWc3m?=
 =?us-ascii?Q?+xHQvqCNbU6aNj39dYsHt5Ds85D3HRV7DwsfMx2DPedqk833+6+670AH+KjC?=
 =?us-ascii?Q?puIb/+PmgOv3Q4VVz9Z8TQkBpiydONluOSislyNrHx79IMmJJ6NgM3BncUCe?=
 =?us-ascii?Q?HEuCzw2BtwNiKHvJIxH1VBobe7DFgyxeq7CQzS7nstc9Po2vYxCuYlzgbpWr?=
 =?us-ascii?Q?Jl4bXVkA1g6xAuaBexDvCKYdEule30/XcWEejbkcNaa/aXThIfT5STzFURwZ?=
 =?us-ascii?Q?RrjuLtxI4mvDg5M0c+seLvQe0+A6OAXElRAIxhk3FjdRJHl2/Snm0YU0Qg/l?=
 =?us-ascii?Q?iSqFgUNF3dp3yYD5U89Nox1hJfP7zURdoOZvKwOBGJE4NvWcVEo+YejJt8xl?=
 =?us-ascii?Q?yHvWUdbaYmun89w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDVb2lLB7tUi0P3amkxcN2K6Pu2SLnl0g8B3hnGgr/l60j9h/Bk7PyWk2jre?=
 =?us-ascii?Q?CIj7/2s0mSUGNKkybdoODLBk4+6q4xcLHlj9Uo0EhIFoJhSNMhr6QYxa5gsl?=
 =?us-ascii?Q?57tp7DYrwSzDLG0TYoYKPllt2K+5s6qs8G0vnngCCgZOu83SBD9kQJeT73Uw?=
 =?us-ascii?Q?rClsfDbge3D4RP4Sr60jRpTHtqrvz0t45gDx5ic/tNy0NQqZ+3Z2BXryq8E/?=
 =?us-ascii?Q?CzylciJULt1tvJezCVx+Wer71/g/FtIo3GUqFUXuZ4zaVcU36eSq8am2Ps7g?=
 =?us-ascii?Q?1m53V0FdgE/p2vryd4mrDmcmYwdRksMPYIRTbFbSpt2xrinP8ybpOFlh55TE?=
 =?us-ascii?Q?hQn0zmIMpqh1z5zMnNbaFCxtYC3S6v0EvD+po4Q8t4SlSA+A9Bn2OvRUjcCv?=
 =?us-ascii?Q?agJXNC0KmYSSfdKjBQZf0zk72zdsNS7ocXOqbVdRAkOR5rlXvzMdIrbNXC6z?=
 =?us-ascii?Q?JpurSjHTtTOGYRY43lIV9eFxGhB1wAQA42DX9QlfbYeaj0NE2iPOABZL7cQq?=
 =?us-ascii?Q?RgqvxOrL4AcdLV5SbyLeDlr9gEnQHwbVL8Ez1lGkcjSvQnbZ/R257vg6BCpN?=
 =?us-ascii?Q?gXQtrcC3gxsT+U8yuJFGRSLqZI6WFOXX7O5rZRafrsSmAVbaBIXSOQlwjw4y?=
 =?us-ascii?Q?PaEBft09QBEcgwM9MWzkK91YLoKgVerxITmF9/ZgydRgL065i054/eKke7Gl?=
 =?us-ascii?Q?KuFnGJoh3ER+vmDX8t0UgvI2odmB4p21fkvBf5+A88qTlPFtOdyGDoAUscjb?=
 =?us-ascii?Q?MEHw30ung4qr9Q6Rv/WrrQXPESfHYQvlWGEFb7EVnqe1n2kufxMVyH4sCDTV?=
 =?us-ascii?Q?z5sef6KIxCU72h/+ll7LufTva69T8ayq/TYYPeEBy3Om2bX2aAs792vETNhF?=
 =?us-ascii?Q?zSyEPpThFAS99KgmTfuWSWSFYd9ewNsp3B9sh3xPeHl0nKTX/WnaYl7ntZ+y?=
 =?us-ascii?Q?k8+Mq0pfMzEd9iqFuPYvTfJlQkJtAcDkyJUwoVDXKFbYEJiZybYqApDiN00b?=
 =?us-ascii?Q?98bOmbTaod5fOIkD1/LhRlWcbi1YholFxEhqFgsJbNIXTp+XOgk6F/NNdH0v?=
 =?us-ascii?Q?uA2y2vGrzXDt3cfdbECKHFQtO0xackC5TjumUQl9ayoLD3akqTQq94TJb6C4?=
 =?us-ascii?Q?r7c5tFfszjeUO8HwbhiVCKNgrtdG4VGWRRMtHHiephmdcZzEXvY3oeLh4NsQ?=
 =?us-ascii?Q?SyeHhfc2U6FaBxRUD4GHSbqBpUAyMUZbjolBWEd+GhGSWMTkRkzMQHg2TCW3?=
 =?us-ascii?Q?D1p4gyStaXu5Vz06DGe6n6zFcKoOKwuqxrwriwOIfMg+nE62GCBGJ9yBUkyJ?=
 =?us-ascii?Q?juyWCEuk8zhtoOwNVYNZAh9mGlgY31+7eHrlCd0w0Xkyf6jSgzzlrtuplEMI?=
 =?us-ascii?Q?LUl6ic3t3zfRXpMyNsClTTrE/f0cts0JhZNl6bJJIXTuk2ggis0M8jREkDzQ?=
 =?us-ascii?Q?+RwN+r6qJhOVyye4cNO6xzKHfvcYezRXZF4IpqEXhKzDLiL9PvoLWHJGv5Xt?=
 =?us-ascii?Q?30SHEtAsxCMa6CTK/vwbU/W0flumVOa7kGcJ2ygZgpKpVcwhenBw+rfvsfve?=
 =?us-ascii?Q?65eoZ6eJ4RsV7Q8+k69PzNVO+6J+Vrv4meTAZCIK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a398ee29-d631-45fc-8e0c-08ddb1f942af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 01:57:07.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw+B8LQEJxZ/Q5QAshAbIjmJFlJyTUUlaIq+HfIj62iqjnByjvte4k2dnDWdJb0trp/eygqdunPtUTlsYwM+aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com

> From: Abhinav Ananthu <abhinav.ogl@gmail.com>
> Sent: Friday, June 20, 2025 4:22 AM
> To: bp@alien8.de
> Cc: Luck, Tony <tony.luck@intel.com>; james.morse@arm.com;
> mchehab@kernel.org; rric@kernel.org; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org; Abhinav Ananthu <abhinav.ogl@gmail.com>
> Subject: [PATCH] edac: Use sysfs_emit_at() in dimmdev_location_show()
>=20
> Replace the use of scnprintf() with sysfs_emit_at() in
> dimmdev_location_show() to format the output into the sysfs buffer.
>=20
> This change improves clarity and ensures proper bounds checking in line w=
ith
> the preferred sysfs_emit() API usage for sysfs 'show'
> functions. The PAGE_SIZE check is now handled internally by the helper.
>=20
> No functional change intended.
>=20
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

LGTM. Thanks.

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

