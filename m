Return-Path: <linux-edac+bounces-2709-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25859F0414
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2024 06:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA7C161FF2
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2024 05:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89840188015;
	Fri, 13 Dec 2024 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/0nabj/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10A187858;
	Fri, 13 Dec 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067055; cv=fail; b=WbJcZo1wF6DCS7RjfVbQsdynTLEl/GzhDJTYaO8V3gkCD4Ef6Kiv0M0QahrW+fsmxsL4lRq9HhYdiwle/9ZfM94jKGl00RcBg+EtHrlbUOJuimxMbWWSgNQiLz6hc4QRfFubggXoo50ZmMuRfmNpfWoB2LSBYp0CbtKyVd/Pv3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067055; c=relaxed/simple;
	bh=y6Ww21c1K5bfUAISaqRWf/Ui54WMu16lPDYqNMyu9/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCZf1B1yJsCGRyQFs2NlkAmjdNU5sQePw+8mWqheov1yqSA06Dfm+F0o8D/K7nKloqGvaux4TbXrHIP2gCYY1dVhBN9vf791XrFTNMhFGJnc/tggx2BEEz2+/30/PcDICKuN/JM/lBTZKTue3XjFQrmHyD3dnAa1OzhSySbAHMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/0nabj/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734067053; x=1765603053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y6Ww21c1K5bfUAISaqRWf/Ui54WMu16lPDYqNMyu9/8=;
  b=S/0nabj/cSFNy3krbwERyTmXvz76cM4Kvzqgvpz9wYc5WDOkuvJtYI5t
   Z3H45cEkTZcxXEB5sA45kBgO4JpoabqQbTtWUZH6Sp8icF6oEpu5G34CL
   gVyMeRffWFx25x4Ys9xK+iBDtfl6yduOQCP34NRXAOsweMnQ5Qm/1JBZb
   ia8uD4h+8AtgqJAOoAJRQn7T6o2kMeiX1xU4Q7zmKI0MHOB3KGi2k8Txu
   cQP/Yq61iwm/0uWXjeo74okCRAmO78v9ZXezRryKu4E40xUjH859sAig8
   4ikY8rELmm4xHW1L1U+Uvxa3EIEHHiCA3zSuHUcX+2+uqxdTK3m2tu71X
   w==;
X-CSE-ConnectionGUID: y35R+q+JRdiln2fkbuMKew==
X-CSE-MsgGUID: HdIR/nizQEul06XKHO2hfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34652791"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34652791"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 21:17:29 -0800
X-CSE-ConnectionGUID: LNMeLFbaSQiuV6fs8pbSkA==
X-CSE-MsgGUID: iC+X0nP8RSSyI2ccpkpejg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96513108"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 21:17:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 21:17:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 21:17:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 12 Dec 2024 21:17:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/XzfAwa2zK00c4LLrtYcG6gmpxTcL6wKTbcFwu5eLhMV7uZiorx+XNtbHkRnQT4rVG4lEgGBjeykm3Dr3/RTAbB9cazmBWwvtPWc13jkp2LWz+gUVocTDz6peRRF3Yx5+x/W+60Fy3DG3g1u3+WcQBCt59iN56/FDT9U/SEOIY6gYX9RkuM2/4mkSmfcthCtZKKhiCrTbkPZ+01c5mkRL2HQACD3OJo9/RNgnDhxwiFOq/36e1WpRRwTUCLu5B9skfeszdh5H2E0tzL35ctCB/J5WkA8eqPw6+jPbeni3NbxYKWH/OKQ9Upln+4ROZ9axvYabzxF/htb/F8gs/a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6Ww21c1K5bfUAISaqRWf/Ui54WMu16lPDYqNMyu9/8=;
 b=MgDNWEX+u6B+WR/85zLtqbcWF3ZdLk8cJ4S9LPnTRZv4ptSrr+HS7qfBjDD6IvkjJLbCzHbVimqJTqFtAvZWDUQPLYyoVq4dDCjPZGEGfQXL/3HQv2RsPZIVxuM+wQJ3l+pjv7lSfno8kKRkKSSQ0xU1vX1tA4qvJy64O1NLOmtagTK6q/vo7Uc295/S6DVqF4U1xy3euZauknIgrraIrvKlxzi24J1woPXVsX6YOxd9Dz+dlTxdYruAAI8yL2ZSe/8Is0e8g4FnJsPnDZGlAIWGq4DtaO4itZsG2fK6uYV5l8499SdqKwhgslADOCgnSsrzufnZiBxpKhtlbKNHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 05:17:25 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 05:17:25 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Meyer, Kyle" <kyle.meyer@hpe.com>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Meyer, Kyle" <kyle.meyer@hpe.com>
Subject: RE: [PATCH v2] EDAC/{i10nm,skx,skx_common}: Support UV systems
Thread-Topic: [PATCH v2] EDAC/{i10nm,skx,skx_common}: Support UV systems
Thread-Index: AQHbTP4SPp05KOIWHUmYuQQpsuHEorLjoacA
Date: Fri, 13 Dec 2024 05:17:25 +0000
Message-ID: <CY8PR11MB71348EA08231D40941DE43D189382@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241213012549.43099-1-kyle.meyer@hpe.com>
In-Reply-To: <20241213012549.43099-1-kyle.meyer@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: f166d4bb-a4c5-4c07-4431-08dd1b356e8e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Bof9R41/kwn3Scuoea7T5sOEGOhhgS0lUCa9yjWPyI5ZSj9WNuEBy10xM1I6?=
 =?us-ascii?Q?eGLl7chg9+wT49WpII/nVXUQg2GxIuCZtoDCGQiJ/qA9+kyhrpiEDFRMWrZl?=
 =?us-ascii?Q?3DJWYyRVClg4cLDe2qTS89juYXZDvqn1tPA3A/YIHkHfkWSXhIvwOKyH/DJ5?=
 =?us-ascii?Q?IyfHFVJ1dfvBKOMCrIFxKKX2Rv+qrTTvJ5WW1iPi228vAxyV7BdVAxrkMnkn?=
 =?us-ascii?Q?XeVEPInwF9glNNhHj0q80kYMkeZiKqaEb0s4OV8e3wFsd7tC0Vh3ikNIgqOy?=
 =?us-ascii?Q?lQnylWqL76wvzMMwGUyeffsCuLfeUIY/RtzQANrHLpE0LfwFCYg97jWcDUmr?=
 =?us-ascii?Q?Su9imjSuaoSp75P7tL9MyMTq0N8s8cGh1j2hSD5M41Y2DPt2m+C1/CuUA3hr?=
 =?us-ascii?Q?BOL8q+Djbv+The2RYupcT2MJNfvpA4ayl2Zbmfwrl+PvW7N9z8hdwYnFxlVn?=
 =?us-ascii?Q?3W1XIarsJwTcJswfLLfLFIIsPuKBVGrqWWfB6FR5U/MJ1RJ69LXShpzptV/d?=
 =?us-ascii?Q?xOG+xDhDpPcCl3LcPJDWZzYdN+JBxOabYVzYVNJP7F9JBVKDif4if6+M1Bgr?=
 =?us-ascii?Q?fiFjskTkgGmEcd/hFG1ssgOPjVu6a9Z6f0pfIs6q/LB1G/cwrFoNNl9/MICE?=
 =?us-ascii?Q?nTluyPj07/q4wJ7wAQqwLFyTzbS3IY2l0yUqCAmdgO1CTQ3RR1pjLuMCVa7M?=
 =?us-ascii?Q?S1X+gJjU1qa5MTQ2DLDhKf08BvcP4aD2oxCSQeQtC0ETQLGQdGVW7LwqpGSe?=
 =?us-ascii?Q?bONkpsb/ASey5puvLeAx71uW0DNdLRkFgDgcjeMFXKtefW6RzWRjswm7Y9ub?=
 =?us-ascii?Q?4BJrqLPWk1z6f3pmZbtcV2ZEg1vYT7/c0/kGzwZmY8wNfZ6YxxINLX6y/dhs?=
 =?us-ascii?Q?3baU4vSrK/A1BLzTDA0nFUzbyaAchOOc/pOp0gS4FMUqjHcri86VqZgXTKRr?=
 =?us-ascii?Q?JSvwRxJSiCnq/FpK1B/lpfPVz1PziV8JvvyWGJR/6cWg/7fYjkXuL+dsWkZL?=
 =?us-ascii?Q?Y1Hi55IGM2rUHmIhyfRKR0R8HU7DwC+HI8Ueo3cDKlVpK/3rYSiOm7XboGwR?=
 =?us-ascii?Q?MzB5pT7yhf+NXU4EugSXHgJRD1eggghLOaKQEtxYAqXjWDYb3zoDDjl6pf7B?=
 =?us-ascii?Q?UR7vI6r+RA9niVFXBhmwCarn7CqxPTCpXvENqHAXF1eho227aUWOQY2RgEe7?=
 =?us-ascii?Q?5cYXwFVb5Ys6rxVT/SYEzXUnXFQKeriTHp+7rSRy9ZBL7BBpq4yqSYU54Zk5?=
 =?us-ascii?Q?2FfYFPID0AtY8IXt0OIkYlIwc/zYJfmtaRCxYvniAPDjNVoS+ImmYMgEEBOr?=
 =?us-ascii?Q?ZY7Sbcut72UiKNwrSort9d55feZ7Bc3cxQLaCWd77OeSnZb1SpxUfQTQ7x26?=
 =?us-ascii?Q?J0YmjTX69yK7tgq4coKJAG+DMWSd5mGavv1rUarf0ZSxsE3H8/o37PQTqnhp?=
 =?us-ascii?Q?lsHU3nVvVyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CoEZpkLv7/mwPeZe+TTAGXurPJjAiqw0UI/DxthU7cZYj2MEgxQXggI5w5w1?=
 =?us-ascii?Q?DMQuf0KGwjsTPYl+/UrqFnjxAB3bmwzurbqTh/q5SFkaanGuptd55I71730T?=
 =?us-ascii?Q?x/5HNQSrPMnZdSrFmvz1KlYp9u+EmBmkVDl8chzU3wifyWmX6xwyZp1DVylz?=
 =?us-ascii?Q?9kkOH0myXWX8cnHzXSi3tttcEGz4KIXGb3JKDtPHmaycFA4dNuLCo88fctMH?=
 =?us-ascii?Q?O7soeCoRvFkvskYnkIKj4FRjBGdob4AaOuu8xk9bo4Bg8sFko4Al1Bk1B3UJ?=
 =?us-ascii?Q?UNjPj/XbeUpuiTNTqzSIlZ4WSRZ7H+tX/uBXXEQYAunJGFT4iRAZozkb+diN?=
 =?us-ascii?Q?RJwjTBpf82rohadTaic+esIaJqSPJNYggtD7gbQNQJs0b5dUqwUVce7IrF/K?=
 =?us-ascii?Q?DR/qGKhstbn/DZ/EYeRvpTJmz5WXoNjRC9NdtJSpoum7NFsFMmjm18udRe8i?=
 =?us-ascii?Q?cryCdYxXqgqf8rEuzJ7x53bLdT4+SkFwfUt3dHvKmx2kvUYOGxcVRNuFPZ+w?=
 =?us-ascii?Q?jeg8gC0jUNHcDByrbECsCVvaM3R9bjMdo9NkvHNjfPa/lBqF7nvnTkFSevK9?=
 =?us-ascii?Q?WhDPt+QqmDlkZq+hhfK5dPHrBb1u0qvVRbG/lSdLyBJFjVhLnceiMpxETjmn?=
 =?us-ascii?Q?+wlA1tTPTba2wamVJ3r5Qty1OihHzb7v9iBvKdk6MOqii3DKuZJjROE32GuB?=
 =?us-ascii?Q?9sAM8BtsJZfGakFCbrjWNVA0XQ4MZF63MsrSU3x1GZvw34C2zgMlVPsAakrL?=
 =?us-ascii?Q?CU0ycHurO80KfsPQKi0h1cUScecgcNyIV7amkkzt0KS57QABdV63OHAE8gop?=
 =?us-ascii?Q?6qHjSVyz9firLoRhLP/9qed4FqHnUQhzv/dbxP77WsW+Stmfot0s0EcUr5Ib?=
 =?us-ascii?Q?Ijxkcz94VE0JArtLjFSfGfrui5yXWHOugv6ky4MAdk4zdfbPxgftymGOe7Mw?=
 =?us-ascii?Q?9vJqfl2PjV9NqKEQ7pypjJpwbd8tRJWnRHth9QNmziCSXz22NKVKMsnT7F1P?=
 =?us-ascii?Q?4ftOqExiHgJ9pleYdbH60PH0tvNk1mVex0yyVzLunHQGqIUVggHztVIXtuB+?=
 =?us-ascii?Q?FGr0Bh7jqojl3PhR0uQYN9HyAAsCffOr1+uI87GNQvJfSGXVp/FawXTyVDwb?=
 =?us-ascii?Q?S5dma2EYc17d+08opD49QeufhZkJK+AVeWtwkP2fx9TVKTu4RslyJIyWe/yh?=
 =?us-ascii?Q?523lq2GmplRYP8PUmOoxO5NIg2Xwii6dp0yOs9HL54uxgQWbg6VPgtgKg3i+?=
 =?us-ascii?Q?jMRyzgYbBMFBpdAfKjUfLXegMYa0xNlzrIKNT6OfJLqBGFRhRZfnlKxLek//?=
 =?us-ascii?Q?Dno1puvtIqyva7wJtsYKJqEG8GdvxiLCE6HAZeYvPqqcEVhu6RajJRJ5GdAR?=
 =?us-ascii?Q?gEaoWFcKpraIr9PH9MrECSoxFLtHt768AJyc+x4iXYE7FCYNM4ov0MOqyAm7?=
 =?us-ascii?Q?HtYS3gnOz/mZjUgcf711PWA3TnKrMO5ONyecc/Ny/ELwDFCg0llvykolUcRF?=
 =?us-ascii?Q?Em3jJSEaxR46Kq7wAehkrdgL+cOw26e765FWu4gu7obYqSGGF4ZMTHoLEYIf?=
 =?us-ascii?Q?ES/s8BNlqHrRPY/CWtWP7ItKTIBwO4L48++aKKjG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f166d4bb-a4c5-4c07-4431-08dd1b356e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 05:17:25.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCJRFsVQOMQ0M4yYuSJw4LyEQVqe7zXx+LlKSeIjLsMHExHwYQp+e7u+MdzDiVnIdFe+rz9qY53SYga/BfWYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

> From: Kyle Meyer <kyle.meyer@hpe.com>
> Sent: Friday, December 13, 2024 9:26 AM
> To: Luck, Tony <tony.luck@intel.com>; bp@alien8.de;
> james.morse@arm.com; mchehab@kernel.org; rric@kernel.org; Zhuo, Qiuxu
> <qiuxu.zhuo@intel.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Meyer, Kyle <kyle.meyer@hpe.com>
> Subject: [PATCH v2] EDAC/{i10nm,skx,skx_common}: Support UV systems
>=20
> The 3-bit source IDs in PCI configuration space registers, used to map de=
vices
> to sockets, are limited to 8 unique IDs, and each ID is local to a UPI/QP=
I
> domain.
>=20
> Source IDs cannot be used to map devices to sockets on UV systems because
> they can exceed 8 sockets and have multiple UPI/QPI domains with identica=
l,
> repeating source IDs.
>=20
> Use NUMA information to get package IDs instead of source IDs on UV
> systems, and use package/source IDs to name IMC information structures.
>=20
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

Thanks for this patch. LGTM.=20
I tested it on a non-UV system and didn't observe any regressions.

Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks!
-Qiuxu




