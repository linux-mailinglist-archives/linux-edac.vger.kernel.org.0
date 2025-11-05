Return-Path: <linux-edac+bounces-5341-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0531C33D64
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 04:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804FD18C2248
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732225228C;
	Wed,  5 Nov 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rji6NYBm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140918C332;
	Wed,  5 Nov 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313035; cv=fail; b=ApNidD1NuH1IJfdreNNQlxQtHt156wOrr8zI8plq2Lp5SElnhz9QyUWnxq32goaqZFrPZGw7DMYdfDBGtG5GeQn4Vrm6WUvbJ07T0wwyAKY+7p+LX7vFwOhtgGeUd+lwFO3NY7n4qts8c1g8BG4hxYWAZWKWNpYJCTU/15L4f8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313035; c=relaxed/simple;
	bh=8WY9iL+RK7yhfBK/kSAtVL6eef+Jg64DKqvWy5lTxi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TqDyaanSzP4OVakRG3Lx37wRSKjkwiTlTnEBIkEatlgkhVw1iUJLL8UXR1Ug2nAefMa6gYgEKvjVHblIHN2PhLrF9DoowHQ/UhCCvBu66v6a4YSITX3PBn4y4bFTy+b+F5zKXV0P6O6peXIR1U98DUCrjHhyBQOGvZrix2RiZpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rji6NYBm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762313034; x=1793849034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8WY9iL+RK7yhfBK/kSAtVL6eef+Jg64DKqvWy5lTxi0=;
  b=Rji6NYBmcxxmnRXc4lZdDvxDffgYgaDv/3jlURoTURUE8UNWb39MeGT3
   i181+irs7Ndg3cXPKNPJrggmW0rw6iwyjX7JAUrR1Six2oOZ0r78ynvjI
   ZDhgkkTgOkIt+B9nT2WKO6wvm2r0ZH+sV9GCBP72pEbTjiJvGR02aHpHv
   EyEz+4Sj80bWgBPltOox5hn2RMCYUIhc7Z3uKqA5h7/eK0Q397VDEvf3x
   dvjqZhEU0N+il7um0UJMtJIPFNZxBK8nMkO2dCD9jJdytOomxehpDDThN
   6UE5LIO+gY4lqQRxFnSmvpj+pRhbLJ7muu+7+KKcGCAf8HSJnaukdGI/a
   A==;
X-CSE-ConnectionGUID: TV+PS63kTwuoCf7f1KeT/Q==
X-CSE-MsgGUID: 7wkR5QOoSmW9OYz6Dk9I4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75100886"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="75100886"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 19:23:52 -0800
X-CSE-ConnectionGUID: XkN9EEliRZS8cll3e8Io8A==
X-CSE-MsgGUID: naG0Pv2WRCGNQuJLK/Wfdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="191627325"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 19:23:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 19:23:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 19:23:51 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 19:23:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLuDXzjbHXjrp5C9v57jsEXicCzlV4Ig4JWXABCyUEvvQXZjyLzieeMp5oUBohFPJeWh9ZIo/ieuTG18gDmAS1j/e7/3fAv/hE5rheJfbN13X059PWzSkKdL4uO+0XTFmOARlHIjvVtYnt9dYnOSJPU4Vjj9zzCo9OdRZSOvH1kW2R/tpXNeJs1ziu+wbQU45sZQe/rZV9BCqes1/2trDEJ0kcuOTJ7hisVMOS1avl5DXrfnZUc+7nAJC6IP8kh4BSd1MgIFohqA1vHnqiY0poLcJXGiViBSkVuKkHEoCBVLuIrHNti8B7TRmAAuX1MYjcYh0C/8wV7AoawgFJlpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WY9iL+RK7yhfBK/kSAtVL6eef+Jg64DKqvWy5lTxi0=;
 b=TUHXd5awcH0BDmLlIDPV22hmlvvLVuEKu4H/UCHf09sUCouQ6bl8mDGPC8dPapjCH31r7kmO+vbwlxgzOBsY5eYjPJcEfR69q+aoLq5T1IX4rhI6beBAahwlIPaw/qk2XU9CGydWSwovrFi3mOdnRpe7lvRREeoeIPDEwooTjJ3v2Oiee2vQxd5lKyFfHzW4HseOufq/04oyHyVhynP28FPp6TdFea2N2wPsSX5K+LXj/+kaoscpWJnQbL94a5UkWth3oVMAP3SV0rps8vE5w3weqttKvgMAlUmFnVD/p9F/ffJdyaak/esc9Xbg+neRUeED8ZDXZFYBylT1wqWDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 03:23:42 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 03:23:42 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, "jbaron@akamai.com" <jbaron@akamai.com>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v2] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Thread-Topic: [PATCH v2] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Thread-Index: AQHcTfsJuVQiZkn2g0++SFHLcF2SUbTjatzQ
Date: Wed, 5 Nov 2025 03:23:42 +0000
Message-ID: <CY8PR11MB7134DA6C1CFEBBD903D9F30D89C5A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251105022146.22105-1-make24@iscas.ac.cn>
In-Reply-To: <20251105022146.22105-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB7001:EE_
x-ms-office365-filtering-correlation-id: e75de6f7-0aa5-4c36-256b-08de1c1ab86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?YGrm5KnHF9vxOplbbF11Z4HZ8j80INNRlshY99nu4fj56MZEo65NG2xTvtRv?=
 =?us-ascii?Q?g5Tek43mVv+eTbHsgGk9ob4R4k20StanYJsezf/H603NDpuResyTNOTQZ+uV?=
 =?us-ascii?Q?SXHjUt9NCXjSBOTvsKAEfo3ORv52iRsTFsbCAmA5h9NC8kyjoSiT7ECw0Rdd?=
 =?us-ascii?Q?zeskQ/5lL+P2DdPs2F/DAdf3pYoSztLOO7uFojm9pvT7j73gWIt3X891sy9Q?=
 =?us-ascii?Q?XqMptcvvhFGt9JUXrCNe+8ape/pK00P5QjbAjJdJGxKvGvCkR1PgHku3DvbI?=
 =?us-ascii?Q?CV80xyEjnxhs5cE1EjHUEATQNWMyn8XNJ2Ftgz+olzoPyXXxdZCZYU+6J4MH?=
 =?us-ascii?Q?0MEISjkGwXdZwr4XIwBYll4sHC8XKpU2dBK+nlp2vOnq9Ub5z6xlhGgOKdgT?=
 =?us-ascii?Q?V0fqdI5U6baq7+QrP23/22mzxZ0IFOzIKyq7alURttcFFvoyMuqydTykc/8N?=
 =?us-ascii?Q?lrVQw41WQDYvEj5AYs055woQb4/7JWYDvoaXvxkOqLz9OxWUzdHroMttZcIp?=
 =?us-ascii?Q?IFoMHYvcD5XbOjtfudgkE5tKbJrpM2Zqz6cuDWawQXS3a5JnqE/cHkGmSqBW?=
 =?us-ascii?Q?8DGhiJg4Y7BAAH5Tq3uIiZBEuiaDtsf6xAxvcpHcGx8IdGB66ixxZ3iumKOS?=
 =?us-ascii?Q?XTYmOFh540kfbDDE5cRaH7hV7ZlcTNjq1BOWM70US3C0onCRx+S6B7X2Es5b?=
 =?us-ascii?Q?PkDofdZB8vJOX426gAgr7AduhWE6Tf8RWZgQbyqMwSk9PQ94tsHnDjaGqbtn?=
 =?us-ascii?Q?iVX9vogLWa6AsP9FkqXGj4QrINnbJcF69hTyaCBEO1Cy9xd4ql6BwFu1lDH/?=
 =?us-ascii?Q?gZHFuVxYkz02ehYh3b3LEsNqdHEqYPh31nwIE1SVoOF2Kwrj63nzXnsxnuGH?=
 =?us-ascii?Q?nKg5YFUvClI07GCzaSfEGty03rrJcOwczMgAYKiZeX9kBLauFDZ2srDheD2p?=
 =?us-ascii?Q?y4YTK8et2ma8Xu0ZfW1It0xAGCL/LDI3RrBw/Ar2Y1HhYXd4YwNY5Ej7ytiX?=
 =?us-ascii?Q?CkkrbGy1Pt3F9mBdQOCDz9xqApRz74aHoULoBS+OLIXymrx6adLsx5V2xS70?=
 =?us-ascii?Q?sQLszCq68tw4l90KLcjf4x1dFWR5bPXeqpTJdU/kshZAJFL4MV2g3oL3W9UE?=
 =?us-ascii?Q?jMYfsKWkNJ7ZJiqpBV6zw6QDGoHGG98hOXloOWr/XewZdW8w2KphW/uCoq9r?=
 =?us-ascii?Q?IR2xfNnv3j6zUFth+rKAxNIHSgGMMwQ510DdeEfxKJB41T1pb30WspAggiRT?=
 =?us-ascii?Q?ixJ6Y9cCrBqCJdmjvUahxgpu5kQlPKCmR8osY3GtPcnxrxj+BCRgGlr1Hqn0?=
 =?us-ascii?Q?ra8jNuLQLnZVhdTYGfKpXgv84lGQX08pt/36WksweL+3rq3eqnLl1nhwuHY3?=
 =?us-ascii?Q?KofcyuD0sgvhvo1FFYTzuIZfzGabj6mO1PkKuQ0V/DLTb6+s9KM7E+fa/kfo?=
 =?us-ascii?Q?bZwJP3eMt9kjg2zJGT5mNc8cjHUkCJHP+alqrUX6ptzpGWCoLIdT/dcH+0Qq?=
 =?us-ascii?Q?H6FcsAMUruPRvV1+7ubQagpJrTT9hhRcFAhc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cNk553LW5bm+c1nfT7wjCDfO9jUKeWYPo/lr8u65bgihfeQEOHYu+wSoHXnC?=
 =?us-ascii?Q?8jpUcvzdGMDO7hm1QMWDyGKoBIyPIDyy3pec/L3xI2NclAIEHHPd5sew1oyV?=
 =?us-ascii?Q?uqt0wikAnklXN7pIIrde/ZwTOsWncrHzGeRq1e5tZMUZnj3NioyFTv9uHnle?=
 =?us-ascii?Q?7861qzZxZqgngnOiNeFb9op8V7N7zyIOZdScqPc+dxzbeafgfInLIQ7YDtBB?=
 =?us-ascii?Q?KafJCPYQob3lzfmoJX4JPuo9ziXrNUXZbuanrpyg8zz+AbVXSqLScdHMLXnu?=
 =?us-ascii?Q?ieFQWKQNniMXVSWYSF+8JYJXgyY37324cCTufvKyd49IfbQxTkRaZtDHOn2t?=
 =?us-ascii?Q?H4/WfrZdw7wkF1lSpTbHB6IEAygxEGf1tliPFuzYSxgJyM3XSWxnZx1o/YEA?=
 =?us-ascii?Q?c776erc0i832I8J8NsobzCnCYB2qwXGkRYqTfuYdVg/POg0JL6eXym1oqSDt?=
 =?us-ascii?Q?7KPlQBRlFbz9uCSWz9AVlCX9Yf9+FjAdWznuHMihoXHqF3biqnblEweH9dup?=
 =?us-ascii?Q?yxTpbt4/DYZL33jfl6K0+b1Wsv4m5F6oba4PpWQDHVEv1XY3tjbcUWytnRP5?=
 =?us-ascii?Q?2h99HW1auKQD6PVQJ0Ll7roAXlVqF1+y2fT28kk/cpYAkLTJhhxtgRKr0eB7?=
 =?us-ascii?Q?RbI+LXpi5hPTpu+M7HDlPwdFRzhYbcXZM40o2RZJOb6jTsg5JjF1apKMYHAl?=
 =?us-ascii?Q?9WNG8vpArUHhq4b3dcS4fXa6UB9QmO34F+w9c7d1Xmbg+jT/lwXIPD1Xik+x?=
 =?us-ascii?Q?Pl4rYXMaHv1jREyB7SduboygL76Eo4/+97uFIZMAcTZNFmWKWv6tjflYJHjT?=
 =?us-ascii?Q?kgH7ay0nhW7B0d/6BZGVBaTHbil/PF3gT/GlzpIubF8g3/Tm3PSW6anthgBS?=
 =?us-ascii?Q?iAFoTdle622+1a+t9LMsiHqTvRUCuD29MPnLDYkl1ZaEstC1OkhemZP49Kzd?=
 =?us-ascii?Q?tLWv63nWEwSE6fz/CNK7FKvF8+FM5ietzMzzHpwwT/N7xhb+MNqfRtiynzqy?=
 =?us-ascii?Q?UPMQzMu2pb6JEzpx9PAP9As2Wopgk8y1adr7psRLswPCQVUlmrqchLDW/lUW?=
 =?us-ascii?Q?hM25bowsjMyHOCCvfMBJ2RH3HdNcf7DGhre1t/5dpNUl5uRcKtIDrkKhJK0w?=
 =?us-ascii?Q?O9dIhDoT1+pNJ9ZjEgjA63ZfXoUB1njxDNx3tKd90yhJz/j9EKUm5BaYy0UE?=
 =?us-ascii?Q?NDbX3EDX0X/t7tT/JJ2+8qz56Kp3WQVIQV9Tc8YDyNnxCb2G5xSsCDqxWBuU?=
 =?us-ascii?Q?bw9w5vYYfVl2OR9xTPwXCxcaZi21QFr4i7Jvg0i5gYal6gZugiWdrOoVQi7I?=
 =?us-ascii?Q?anBYadeJhfT8GvFGg8sSt8qUafUrMCJnRhk30Yr2N5yyXJ9FRR9wr2/q2jUF?=
 =?us-ascii?Q?X1GtIB9nSHumliYDClmWEjaTVncebMKNA54z7dvsUOdzo0/fDoWDktTZS/2R?=
 =?us-ascii?Q?4KLUAGxwTlVq2b9xjP65uqu13SxmaG8YPTnTbp8/gmGygXDH9u+NDeMIEimh?=
 =?us-ascii?Q?Kh9R+Zc6n7RhcflFJZN+GvIeaP2Hr4JjpNnKEw406Ce+z5asRkImSPJGW1JD?=
 =?us-ascii?Q?PLxP0jsvd8F0Ha5rDr2iLMerD03j7bsCTZCJYHOZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e75de6f7-0aa5-4c36-256b-08de1c1ab86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 03:23:42.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWeld/VZcoWhpABvHRH8cvfgwOKgL35Nb60PHozjTvDpzOlD4sxoNOqIvG1RWI3fne8nv9OWNbbbGjRTx4Q7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

> From: Ma Ke <make24@iscas.ac.cn>
> Sent: Wednesday, November 5, 2025 10:22 AM
> To: jbaron@akamai.com; bp@alien8.de; Luck, Tony <tony.luck@intel.com>;
> Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; akpm@linux-
> foundation.org; Ma Ke <make24@iscas.ac.cn>
> Subject: [PATCH v2] EDAC/ie31200: Fix error handling in ie31200_register_=
mci
>=20
> ie31200_register_mci() calls device_initialize() for priv->dev unconditio=
nally.
> However, in the error path, put_device() is not called, leading to an
> imbalance. Similarly, in the unload path,
> put_device() is missing.
>=20
> Although edac_mc_free() eventually frees the memory, it does not release =
the
> device initialized by device_initialize(). For code readability and prope=
r pairing
> of device_initialize()/put_device(), add put_device() calls in both error=
 and
> unload paths.
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

LGTM, thanks.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

