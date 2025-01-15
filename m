Return-Path: <linux-edac+bounces-2923-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D9A1255C
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3583A81A8
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6824225A;
	Wed, 15 Jan 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECeEr0CL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8E29A5;
	Wed, 15 Jan 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948785; cv=fail; b=ZzpPFLjaUFa2Az/nYxxnzVCLnlN2zzR8w0FMvNjCLZMLyBk7tfgdKt8amPm/Ck+UaToJQd8Kt4ASixnl9Cqi0YqbY8SN8NxGRNDQLD5ojeIgY7wBl70oH92/Rs9EzCRBWs6OPdl06R1qibn+Ru8btD0bnP+QfOxuztKmhxjJy14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948785; c=relaxed/simple;
	bh=m/f86DnLuW40KgAVWPP9tY9jK/ax/2Kx8i9t9KRr+G8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1pqvkDAilxYKzl+/g1a2wnzH9tUX0aFVvzEaDCDQIH6yvOUbK806FDFd8/Uy4VBycUyrYqNAnPPRPdy7FApkej7bHRXocCTO+K15N/8JdC1T3imk0RFcunS8fLlEUYT//23J2KNTzNVqLzKKB4uAgNZLrMc2S4ub2nq/y/LNw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECeEr0CL; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736948784; x=1768484784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m/f86DnLuW40KgAVWPP9tY9jK/ax/2Kx8i9t9KRr+G8=;
  b=ECeEr0CLLyNDAEgOt6QvjT2tzXeHci/KYUI7xRmavKvguzH5z/yJMpby
   DCNAZVJ/QdEPxpAIFz7Y64FbCTErP47zzPh/iRnByVQj5uSove8C46wLA
   83ymziMLSJHJytZbZpW4eNCRKwX9LtmdKX1/chcMqNQqFKcE5EZq+iaE1
   jlTdyVuivdJjxnR4v3DNEFO272h5QAp8KbW98dhzLTqG7pyd83XObNiR8
   QXICCRE6iRIrbKdOkm/zisFlV1z7yXa3LRVuOdp3yvJbWBHQDCxA+Ke5N
   TERQBkv/Yz8Pm7gbB83ixs9Fr8UAaKBYJQOwdqfwX2Bd84wgLcZ2gTsOa
   g==;
X-CSE-ConnectionGUID: M0wXgsaJR+657DrRUMJUTA==
X-CSE-MsgGUID: pJk9wTQjT36FB49Jb2bYKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37312272"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37312272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 05:46:24 -0800
X-CSE-ConnectionGUID: ls6JYXQpSBG1KPRCGhtp4g==
X-CSE-MsgGUID: +XjJHnSERf2rHHFaJGW+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109771876"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 05:46:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 05:46:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 05:46:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 05:46:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ1layUGNH83Aa818SDVM4zJGE1VvpMspHU6HBcevWtkZHEzWVSBFLn0FF7cy6YjT1f6SpeIU0nKXQgGzo3RIcexJXk3zN7dUKiWABaO3OFZkTSJhyJpmC6i6txo/m0yi17NnLraPQaF77Xgat4xE76rW5qvIn/I6NliaUM7ihS5LJ0zXziSuZhc06wNcB4uPP9ToJCnkCASvhXAmKZxtRKn/mGapCnaRQ3+GdXml6xJHg7uPgDYG54Jujvxihfq7QvMHb/iUZWc1T/OdE4sir08UD4C+J2lVQfhAU/pA6mCWlMO0UUTh9zqYaog1Lb7Hotefin3wP6qeReculuwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUSQD5E/4eYmf2dA0q3KPTRhCo4xM+7xpeDlx6/VYmU=;
 b=u9eHOkA9fuJ4jU8NLcixYpVJ4Jbggz7ouWPy9PmbXXNFvuII3+TZxoagSaGnQMKLiyvsRz9CKzfnTICT3S9RSb+yzItL3TgUcN+eHfEDXwmfuYSFRFqpTWP6gvt+58j1j2j0nrLeQw4ofC7WRL0iLxBuK3qP6j5qrIPZ9sKroJKdk6AqT82icr1G0pVOi4VTCWNn5y+PcvUB1uV1Wh64ZlANXAPaJB7jnT18QU9xU21mrK85xosC/QqlhqZNbRHKqrdpRvpv36hiXpAO4Z26hsQo6caSJwnWk12ruLN+2yZLvdM50VNJ+tFVRbDRSey1HkNN3nzmZCdf28b1sqlnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 13:45:52 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 13:45:52 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: RE: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Thread-Topic: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Thread-Index: AQHbZyBULE3CljfIAUqEblQV0t0RvrMX12qg
Date: Wed, 15 Jan 2025 13:45:52 +0000
Message-ID: <CY8PR11MB7134DEA89B78F45AA20C1C2E89192@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-4-nik.borisov@suse.com>
In-Reply-To: <20250115073640.77099-4-nik.borisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB7524:EE_
x-ms-office365-filtering-correlation-id: 26d09aaa-63f9-4c8a-6b4f-08dd356aed6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?g1nUQScPMPiRsS5ibF9o86AFh2VKdECIl8LBr5Z2b0VJ55HitAfv5GtLZIbk?=
 =?us-ascii?Q?zxK2+6BgbJ2QJ8sWDC72yWG8VqN8a7mU/O6zQjIxBE9WiPaHDLXf4Kt854QG?=
 =?us-ascii?Q?KUk+Ocxqx1G/rJMY5YxbURM+yEmloHLUxQdHBVw+j0fTdwM1SJBh8sUMqbrk?=
 =?us-ascii?Q?DI55nG1HY9JZBwoTLuExidRPovxelQccE/6o2K1hbzBAAc1dq+c294epZwhw?=
 =?us-ascii?Q?cSQ5boWXD0zIfwFdiH5XyR0eJ7vAGOBKxYqJ+FHOAKkHkU4yDiyeZbuWvKUa?=
 =?us-ascii?Q?OBJ5Pw7VH31A3JrKoJUn6x6hOSmBX3Ujbi6gss6h5HNWQuGXZwN7B94Hpnla?=
 =?us-ascii?Q?VsNgs0LdUX+Qq85FtdRnG2uhXI1Q8qItwpEaNbKdJ2SVAxPBPMd/wI9bDnIU?=
 =?us-ascii?Q?4lzEC5mn418tjJJnZv/eL7GK8hCEN0nXLYFay2ZIICUWQdJkVmQ1yR0PBFPj?=
 =?us-ascii?Q?kyk86H3c4y/0Ja8PSVap5gckfvuxzSHQ/il0yjnD4Lh1Y2aOCk51wIaZWWsq?=
 =?us-ascii?Q?oco3t3zUqkkWEGB6u0/AgBcjcsxK9sP03t4c+GYD/l1e/9bJ+OsXqCAVjeml?=
 =?us-ascii?Q?1Yrq3HdrucYeKNo245E6OoCmGWs7Hyp6DqF7kS9lQZlUqLoz3aEB/hYfb02Y?=
 =?us-ascii?Q?As3xA4AEGDudHPmAxzm4eD+3oTL1vmWMZP2/UkPNTngID3liDXE5ZcuUepL/?=
 =?us-ascii?Q?nmrEEcXngGD2hxEtCR8e2ISyzxR9cPZ6nD2lvQj5ZFxNHADgPsjKm/TNbBxI?=
 =?us-ascii?Q?vQglXnW7U8nS7G8ejHRaLz8uEFmDP0DX9WmoJ/rFdAhQNY1waPaJ19AFaavW?=
 =?us-ascii?Q?DWVVJUhWUiFbNN5QEdWoNYmY3cOWaCg7dNkMAYy7wr5z8QxuwH2YsYkQwmkK?=
 =?us-ascii?Q?OigQdSk+VM93qouBw8i5Gz9OnqIdlX9mch6WTS56ow3ljrqzVdPABbBAisLp?=
 =?us-ascii?Q?T7lybksBPxxwRPKayvTuHiiATV7GBNrVbxy4CzN2NBxlIGOUkv0fK5guKu6P?=
 =?us-ascii?Q?PFR/jTg4Nb3qBBVDEaN4qQYCUyG5Gwso/fFPhuEAlpXrIExi+/5idXSPjB0m?=
 =?us-ascii?Q?4EL4gNXL2zFVV87HqhqRNxVOxV1SVel7OhTmY+QCj6rqRMN0G/55n+zwdW3W?=
 =?us-ascii?Q?M5322rMjzQxWnHGJPrbikeQH5ca41luMGFDInxrrIQijvTE0BXC6urcHylMi?=
 =?us-ascii?Q?XmoNWjxxhDHIQsU06xcPoRN88ckhz1HRzN+f2s/qm+qrl2FC2HOQHhMWWRPx?=
 =?us-ascii?Q?nx/2+ewb6YDffayPfGUePzs4L5mImY4o4in3aqRLvx9Q+2bKDyHEFHAZWEru?=
 =?us-ascii?Q?OQ2K4eTMfF0DZdb3/Kk4ciKtreKyL9L3nsAX5GMvBLH2odgzmwqQYF/7Pj2M?=
 =?us-ascii?Q?lrePvZeB3brBDYrpIQZiElA8cOz4lxRWYUKNK0e/mbpB659bGZCsjwlcAcuD?=
 =?us-ascii?Q?Jne7CsKJBySjtwfvyRmQyWrwoem2kK3H?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WkPaVnSCAb6ucvRAKrfRFz8u5+ztvTiDBqQwNGtzdJiimjIPiKZRE6hwxlUt?=
 =?us-ascii?Q?52xvwqEiBcUCtgfb8NxxzWrQVtGRy+4T4Qei6UydfAwDc+vdsUWlz3JDa0tB?=
 =?us-ascii?Q?m1NttBTNqyMhy2+RGZpNtvAVpJqRoHOpoyVCod2PKrqV/yDmse9QLSGs9k1o?=
 =?us-ascii?Q?F+aDEH8+ddZFygJyltOR0J49CqzPdQJFohXRJ8/iaduMxq2gBVghURhktVI/?=
 =?us-ascii?Q?b2BScYSrX/scTlp8PiyEiFhriIqEasKugxgQJBqGFjJ1mZFVP458WzLgfogh?=
 =?us-ascii?Q?OejIb4QqLimV2At9ct0Bq1c7o90vjh/DGRXNOnn2poEYN/YJAcsWx6E6AwDv?=
 =?us-ascii?Q?bf+d7E3RrenRfS6UVHoEBpjMQeASxII2nvHByH92ITD2Im+FuwsNWwTkfeWW?=
 =?us-ascii?Q?xd67/ZsUxhy5mRd7v5lUYyVAJ7A35CWoQ2P075bmy42YtdrXSoVakDIgnOip?=
 =?us-ascii?Q?GB976yRBl6T2DV6OTiAvGBvqzDpNKCNujFsWkB8+V4g5K0TRLmncnA0tX3AH?=
 =?us-ascii?Q?Q+IqL818W9mX9d83mW/qR6BsQfdEyWfTRVP7r0Qn/WLn5T6kGSGWXj1LRtSF?=
 =?us-ascii?Q?JqpIFokKxeQSQ3LZ2209B3bdIk3mPZlQJ2hC2+JyalKBU236uZxIF6LhhLEM?=
 =?us-ascii?Q?sGQ5cCT0yrRsfeWrygSd+iDUR84j+/QKcX7KKOuD6XkvjaAMaHeEOaDZQAEp?=
 =?us-ascii?Q?XxhJjjos1UaGIE/bGvntQz1zueSFf3RfztfQL/XBP44qD8wbQLPM6MiTW+1v?=
 =?us-ascii?Q?s7u8iEa1TmPIpuFtf4IiYpp3scmlamZYATpVmmYjGOtV/86A5ZYsrYW/metr?=
 =?us-ascii?Q?n0aaVvQa6JTuRSK4uWbbJ8w5NG5xYTQPc9I9EEOgDBXQLwy6BGWYwxhzT7FK?=
 =?us-ascii?Q?0sjhlKPVYc5ByFmih/ZuucpmgWWTdvZA6KhhnRIIeV/Auh4v33VmBWRYgr+q?=
 =?us-ascii?Q?6EcxL6H4zSRX8o7YxH+vbcyvPsf/v9d3rElusBaXFKcU+QTAZtJrAtVQoNw5?=
 =?us-ascii?Q?C3Jvgnzb2QMP9HXVOT45ezzxOux+u261qFayPYNMY8lf/tQuyg4gdHoRQt0F?=
 =?us-ascii?Q?x9eOeaBI0Dw7uZH73186ziJCjWh6nNqrz6ATZPJ4AXcWUpUebTnVpxMLIXSn?=
 =?us-ascii?Q?ABS1Tj3z7ycSKpeINto8CDM+n8IswEBYQecTM4/ANjKSEI5PbbsyBIgnuUMO?=
 =?us-ascii?Q?KLifMbH/sia4+XfiFiIouPzpt4OLXnYMqVPLVZK5UfSxs92BFw/umO2hG0HK?=
 =?us-ascii?Q?MQN+avNe047ZXppO/QNdL9kBjFo2DWXHWmtFHye0VBLgY9KunAqtJB3R/i7e?=
 =?us-ascii?Q?VaxpzFM8Zltk52ZhOlWFA37R9pUsDkILL0shclH++WG+DOiFDYLkdXYSjZOo?=
 =?us-ascii?Q?XumtPGdK/FC8IdulpH1WYNv02a99MTtckqH0lkNw82dTWjAK2tvv+ub12eIt?=
 =?us-ascii?Q?LNmFV7EBodC5NCk83WQAioXRDIMogyMl/roOkbx6DdW6yput0RSx8ztZByX+?=
 =?us-ascii?Q?DVSPwV76rpNSG41R2ydD3rmjYiTGZQOCvSVUoE2SDEOoiPyq9xjMow1Ue9Xp?=
 =?us-ascii?Q?MbZTmUhoMcPY7fJZNA3wcP5vowjmIFnJ3bqv1HCX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d09aaa-63f9-4c8a-6b4f-08dd356aed6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 13:45:52.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/1katuuHPYYkRhGfxeGOi8vskWeDYaicV2YJxD3dhS9eNaibPPazm4TWVQt1MVNBO0reOXl4P4kLy3GTxyUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com

> From: Nikolay Borisov <nik.borisov@suse.com>
> Sent: Wednesday, January 15, 2025 3:37 PM
> To: linux-edac@vger.kernel.org
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@alien8.de; Nikolay
> Borisov <nik.borisov@suse.com>
> Subject: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
> CONFIG_X86_MCELOG_LEGACY
>=20
> mce_notify_irq() really depends on the legacy mcelog being enabled as
> otherwise mce_work_trigger() will never schedule the trigger work as
> mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.
>=20
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index 89625ff79c3b..b21aa1494da0 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -591,6 +591,7 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
>   */
>  static int mce_notify_irq(void)
>  {
> +#ifdef CONFIG_X86_MCELOG_LEGACY
>  	/* Not more than two messages every minute */
>  	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>=20
> @@ -602,7 +603,7 @@ static int mce_notify_irq(void)
>=20

The message printed inside this function should not depend on=20
CONFIG_X86_MCELOG_LEGACY.  User-space tools/scripts might look for this
message to detect machine events. It is also useful for debugging purposes.

   if (__ratelimit(&ratelimit))
       pr_info(HW_ERR "Machine check events logged\n");

>  		return 1;
>  	}
> -
> +#endif
>  	return 0;
>  }
>=20
> --
> 2.43.0
>=20


