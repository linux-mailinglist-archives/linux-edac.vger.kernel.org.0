Return-Path: <linux-edac+bounces-2016-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5D99B14A
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D68B228E6
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841E13A25F;
	Sat, 12 Oct 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWdAnPzK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB184D0F;
	Sat, 12 Oct 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728715291; cv=fail; b=AFG/fZfwB3CW+Kc3M6boSriY0CKQI501QivVN8QMsx3oQkZ2Dl1UI0dosP5Zaa86kDVSf+cWFub/6CEBQaXCyy+Ln9iTHq5FvmapOw/0TiVFWm6JOnzO6Ss4zASank2BSVW3RSScOGc1utnwcGKQtBIv2/K1s9o4GFaeGynXFUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728715291; c=relaxed/simple;
	bh=o86JiksrjnZYxWqcFxLQaHSiljLPWxFR93n3VfZarJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiHI5cDb0RoCSqsV0Olrhz9GfWYxP8P528X1eRTtXOBH+GXIC39c17I0b45RKYZkky4Pn8zFPJ+MUH4LVLQ52ogWnUXO7po5umJ2HcCtejcioGAALrCV+Ms2DUCu9TFVvR1RZfuwRko6lDvrmp0oBe0f0d/yUjwmLAD9CnaXYAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWdAnPzK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728715288; x=1760251288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o86JiksrjnZYxWqcFxLQaHSiljLPWxFR93n3VfZarJ8=;
  b=cWdAnPzKTP1LH65udxn5vAVvpw/cO9IhG/kxAJkL9M+BF2qrud0amGvn
   9AH0DYF5xW8tcKpZaOHP0OUVbtkulH/LEdiAX9i2fiUTPInfud0j6/Opg
   v1rhqVkqKMuy0cTeQesLQwjV7SiMUpCYAcQBxyCxN8/ZXfL34RZVfvYbT
   5wQxrfy6nP62KuXpjvHw+ff3v7BgRRiQvhJquXgJQpO4s73DKwgLm13jk
   AfAyryTtmCNbsf1krbucb0WEy+pzqOYlqRb9ro0mfjHIBktt+f3q3kAsO
   2bfJyY/5KQu/ncSX3CE4J5zpcxcuS4as+bXCeakU1BSln2H65dxLkrVW7
   Q==;
X-CSE-ConnectionGUID: aMR7dtYpTTGm/FypGMIg8w==
X-CSE-MsgGUID: DT3KFqnoQICNAuPqeYPdgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31912615"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="31912615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:41:27 -0700
X-CSE-ConnectionGUID: jJI5N6pfSWOQF4zNDnTcuw==
X-CSE-MsgGUID: yZwDFa9nSWO/LDCTXGeAeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="100427825"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 23:41:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 23:41:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 23:41:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 23:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1krnvRFqxyMhp/tB2LW5UNwqp+vm2TV2C3Ja9vRXFK4ae1NawhywumfKVakVpBORYAOwpMkNSVDvUa4Mse3n14flystOMALLep/rPFhEadjZMvf5LYuCq+p3cmuqhABhu6nHWnMmkuzf3gpW+IBoW08R1axToODAx0EQu4GdJnAwE9e9kSQA+0f852B7RZiI7wZDnXCJ8zKG82cgi76w0IltVkMhOHAMXcXM23cte/MN/Ks7rr7/9W3uCgAxqjMpgM8URnmAtFopUfvIBgSK3zWRp3tIlUzYZNXeh5E1sWjSiPGj/ORtVwNh6bmuRqF5neSXaZWbEHppa98Zzh7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UzHg19wc/sSJq+xUDOFnl6mf91oqxussXyEvnU6rK8=;
 b=UAWD5I88ozNDiUDPfNxhC/b9+TzL7uYfAmwzvBuUgcljT/xmwsqPFVnlpZBMDh/DIIaltRvnhBAcF698F7v3wnWVRDoGIqnawwo36GxWv/PW52sPqgTgyWfr8d60T12vkK7jHrqX26F92inCZQZwvEQ/eqjovYe+0QoJp+25m82JxQzJhgRmEn5Ur2QFZ2qhQU4Q6I9nU12D549BhHTPie0Blan3/a0FajMv3/IRov0NgEvUxMSafxi6bsV20UXVmWmcriIuNzh4eAYt7tGPAPYv3f3M8k1Z2dvcQ4mhr7JNiDCcMIS9Qomj8Y4E6QT6C5Yrwq5jSNLENpjBewQlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sat, 12 Oct
 2024 06:41:21 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 06:41:20 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v4 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Thread-Topic: [PATCH v4 3/4] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Thread-Index: AQHbDYuMlBzIJKUlfk2Qfcrk3AxZR7KCwhyg
Date: Sat, 12 Oct 2024 06:41:20 +0000
Message-ID: <CY8PR11MB7134431FEEF5A9EA6A7CD3E7897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-4-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240923073311.4290-4-TonyWWang-oc@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB4792:EE_
x-ms-office365-filtering-correlation-id: 6eaa5db3-b22c-4103-7b0d-08dcea88e1b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?wjxE5AZdL0Rg2XQaKhN5xDid++YyP6pS5wB1EmPeyztyo+gihBOHYFT5CZLR?=
 =?us-ascii?Q?RZh9KyYFJFRrIx+221zl+KKoyGWIhE/Pg7RBdtLq3tTfi6jZ38uEWGnqmDaK?=
 =?us-ascii?Q?fCz2jr9g+3w+735H7Cex1/Zzh8GA3LGqwkY8rUGhS+sbUR5gGzujLAjFlVui?=
 =?us-ascii?Q?0uziKVcUQsDfg2YLbNKjbQGTsCzG2yWRYuTa8xkOuUNhCuBPC0z3tWyAhvjf?=
 =?us-ascii?Q?V7ylovawY3pM141ZhsCEndbZUHskO6Q4a5EGSE3uN1qvcpR8/jFPyUgz6yry?=
 =?us-ascii?Q?8leAN48csdDVv1C13cWqinvcyraL1mGgONA8tpE6lwu6LIrI9SmOvNuBkrCB?=
 =?us-ascii?Q?DTEEpjou6eNWq0nNml1LHoRwNuKzORjDr3Hqvk+1Cf18x7Fo4AKVpPkP2LQg?=
 =?us-ascii?Q?9B9fMM7byfQDvzJj6UDJkg1cE+0B8f0RVTOuXlJ8R8iXLd3ntnP+Z5qe/jRP?=
 =?us-ascii?Q?evVqX3iBQjAa3FvZrwhPI8txF8agBVvzn14VlmZGrcP79dhdswtjmjj9jlnx?=
 =?us-ascii?Q?niHsiRm8KnAttQipNVimJDDjsNHi8zUdVPWeRZgL50e2rh6tMbqupHQKUCaz?=
 =?us-ascii?Q?HauxmcEIX+B0kF9mxBe+1se7DXZFqjRzNmrhoW4+v23z/828QqMnFloX/rsl?=
 =?us-ascii?Q?N8UejVdSe4bFd4YMKfMuPHb+1EVSSkwbopYint1YVSNQWEH4/MFz/bOvn6BM?=
 =?us-ascii?Q?Tw4OFt7244bQ7H5M6CSbhzgYVR8cM0nyQqlpkiizKlgWiE3R3wPbxtHgnhpS?=
 =?us-ascii?Q?SwoYFkSKIA9rShMF7HwK7Tay0WDiNqj/rYODxYCnHi0AdtqVFy5xc31RxTNg?=
 =?us-ascii?Q?MJT0a6gkIh9usjYrYilWlbQnLZU8tZPHlq2bpc/FW5bcdzOzVa3iDZZu8omc?=
 =?us-ascii?Q?V+Y2Is9EjHc3Dx79jz9I52PRA4fYe+B8joYuj0p5H4sr1b81S3E9k4+kUNJD?=
 =?us-ascii?Q?l+0es7iN3hieqpVfRirskE5pkIAc2Nzh1NJGgZDx16W6aq8XSUcxcqP4zEYd?=
 =?us-ascii?Q?NpjFDRE6fzLKLiyvp/zZYpdu8xM4FTdgRmH+aukVl3LzxSW0rAe0S/KsNJf3?=
 =?us-ascii?Q?4VvckF1PsumTzadFfEYMndUEkNXYv2yKV5uP8LzZh+wRwouYBaGc2/hacums?=
 =?us-ascii?Q?gs00q0D9KhG5cnDmMSo3wPfqAUnGBM9JWxAauxbs2ZJG133bCdOblJK1+27q?=
 =?us-ascii?Q?sqbkyLfG0lczZPWQsTtomUksWxeC6vUjIs7NoBuKS8yjz4djK28ef78s8qiz?=
 =?us-ascii?Q?AoakKi/ctPfKzryTwROZHijJNhWexHMf/6vx48IEBGGtPR1r7pbb4zRtglBy?=
 =?us-ascii?Q?jnAr69DOqWclbjNov+fBRMeBnmMGf306/O0qutRX5QjTdhcoYFBGc5s1CB1Y?=
 =?us-ascii?Q?YMjJ/S4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hVOhMxRJt0qyXiBLdFY467gHcEaV9Znitc4vr3KTzI0VBPDAjW5ZsC5l7bZ/?=
 =?us-ascii?Q?9amogKutAma6gLA+wcYSpmALDfeiJsGDTIE5xyw6xEk4mxAcWG4uUBvoVgbc?=
 =?us-ascii?Q?eY8OJWs7NlGK5jqXQkjiskgrRd64ESKLgxByNbma2IGUfcYERMKLWj61YYnA?=
 =?us-ascii?Q?DU+lDwZ6fZ9QbmJIQDmzpqp5HtFe0exrlgWLLzV1yAiS7kNPkiKewudSA7XQ?=
 =?us-ascii?Q?HE1X+rpK/K6p1k/21GlZKsVJBi8mc1jlh8FNVwpRn3D4A1CU7Lxq2AIq3+g7?=
 =?us-ascii?Q?HJK0c+kW5N34Gh6yERyQxY2jbFd+Q0vkNHHvOE3dTZuQaRH0v97ytP8lXaYw?=
 =?us-ascii?Q?tQePIJ1uUqCR+arvuNr2KH7NBbU77EisKk5xtXWPWqC84JZ+ViiqOInT9wsA?=
 =?us-ascii?Q?lTXefq/2bNleRTM8HfQpn1RDByd8JLMzpjqd1+YgBcovLVOqIuQjLzXPkRII?=
 =?us-ascii?Q?kTQ+mJR//5FgpRsiI7e/G/3CmkJrcT2ZD/z+ssushjYvqArn/GC2mVXn7PMj?=
 =?us-ascii?Q?ENe3OFuqSnDlqGLqWKUM7lpf3u0l2o70gFIxmuNNKBb2pA12OaYFyKZnIvyq?=
 =?us-ascii?Q?ctQYiQh1R09ho2CaWME3YDjzTU+rjAPGc6iinjLBFj3s639qNZrGgigjvJjW?=
 =?us-ascii?Q?DlmS2+PxQe3Vhd50vHvdwyaGc8TXBaclj+EgIlyBcvmkXl6U+Ls1ZYPNSzpM?=
 =?us-ascii?Q?NitSdnAwLVEc8/PEsRUSnmxJNC6ZmlQ935b4lr2hOPNlwGlwWWpUKALWu9E9?=
 =?us-ascii?Q?o082N+nhS0MWEfOCRKoLJSugLwlzqlkGPQRLOHNx9JgUxjrs/lI3D5oqkZ1+?=
 =?us-ascii?Q?CGa9fWh9kxTynVuv1OcDXNWhRuhoAEw+4IJFUzYt/CMYXW39Jat5y21FTYO4?=
 =?us-ascii?Q?q1RfMZmayQlxcQJQvOZH38qh7C9qq8aPYdxXDRW0CfuoVrp5Bn9/Dh2wIjTW?=
 =?us-ascii?Q?kC2qXFL3RGIwtgoS6Q3q382IFEFhL2lR1B9L383kREyxLvJ8BZitgcmINuBm?=
 =?us-ascii?Q?Z5lktbvyeV6TlIFJR38AZh01jocRiSG8Voj8rT4+Z9zfiJ43AMheFxSKurKJ?=
 =?us-ascii?Q?AGQb4ERQ5v5wnMI/k5dr9PEHqtJD/lOhieWOidm5GJNmuB1NWoOTjxHtUuH8?=
 =?us-ascii?Q?aMDHZy5uuGsBk0MZm7i2ZMZTEPDxv2+15Y0hXnOP7IwgeUOIzwNlVb0DNp21?=
 =?us-ascii?Q?svzOJkXeJqm1C/SZUkoDLWAEXXRxhetZ5PO4UKR6ABXrscVRUOwTKQB9kAm1?=
 =?us-ascii?Q?eHUmiek5P/T1FRbLVhAyKtWPxIaqQUKU+Fm/5wuFYJ3iif1xMoGUKv6TRSui?=
 =?us-ascii?Q?n0aWxIAKDFEY3PcF14tra5lbkJW/CZfh1jWQGuygJAcxUX8PgWp0WDXij0lL?=
 =?us-ascii?Q?Kz5Qsbien7QdWPw71S8tQdXTply9rFahy6S8JgiqMLyQS7db0en1mHnSM8TH?=
 =?us-ascii?Q?Qm920xLi8dxlXDmPcpSIuasmr+J0Kixc3y3YKbr9yohE8aiZc7odv9/V2WnQ?=
 =?us-ascii?Q?8S2K5nlFYJS3ATsSigqHq+lxM1wWTDZlvgUkk8EsUlesKcGRUOidyQjzQEQ8?=
 =?us-ascii?Q?GztAHXcsbmd5zXd6MBoWlZoGx/U0f8yjj9LO4u8N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaa5db3-b22c-4103-7b0d-08dcea88e1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 06:41:20.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSm5GSWkZz9Tb2a3igK0YTUlMeyayhxDUhEil4uVg+hstfq7/ux7Lpe1X8temM2o0ifWrP+ObSN72f8+UT1Kig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com

> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> [...]
> +config X86_MCE_ZHAOXIN
> +	def_bool y
> +	prompt "Zhaoxin MCE features"
> +	depends on X86_MCE_INTEL
> +	help
> +	  Additional support for zhaoxin specific MCE features such as

s/zhaoxin/Zhaoxin

> +	  the corrected machine check interrupt.
> +
>  config X86_MCE_AMD
>  	def_bool y
>  	prompt "AMD MCE features"
> diff --git a/arch/x86/kernel/cpu/mce/Makefile
> b/arch/x86/kernel/cpu/mce/Makefile
> index 015856abd..2e863e78d 100644
> --- a/arch/x86/kernel/cpu/mce/Makefile
> +++ b/arch/x86/kernel/cpu/mce/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_X86_ANCIENT_MCE)	+=3D winchip.o p5.o
>  obj-$(CONFIG_X86_MCE_INTEL)	+=3D intel.o
>  obj-$(CONFIG_X86_MCE_AMD)	+=3D amd.o
>  obj-$(CONFIG_X86_MCE_THRESHOLD) +=3D threshold.o
> -
> +obj-$(CONFIG_X86_MCE_ZHAOXIN)   +=3D zhaoxin.o

Move this newly added item just after AMD's, so they're sorted in vendors.=
=20
And keep a blank line here as it was.

>  mce-inject-y			:=3D inject.o
>  obj-$(CONFIG_X86_MCE_INJECT)	+=3D mce-inject.o
>=20
> [...]
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zhaoxin specific MCE features
> + * Author: Lyle Li
> + */
> +#include <asm/msr.h>
> +#include "internal.h"
> +
> +static void mce_zhaoxin_apply_mce_broadcast(struct cpuinfo_x86 *c) {
> +	struct mca_config *cfg =3D &mca_cfg;
> +
> +	/* Older CPUs do not do MCE broadcast */

s/MCE broadcast/MCE broadcast:/

> +	if (c->x86 < 6)
> +		return;
> +	/*
> +	 * All newer Zhaoxin and Centaur CPUs support MCE broadcasting.
> Enable
> +	 * synchronization with a one second timeout.
> +	 */


Instead of copying and pasting the redundant comments, could you use Dave's=
 concise comments as suggested in:

   https://lore.kernel.org/all/a25f878e-83d9-440a-9741-4cf86db4a716@intel.c=
om/

/* All newer ones do: */
> +	if (c->x86 > 6)
> +		goto mce_broadcast;
> +

/* Family 6 is mixed: */
> +	if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
> +		if (c->x86_model =3D=3D 0xf && c->x86_stepping >=3D 0xe)
> +			goto mce_broadcast;
> +	} else if (c->x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
> +		if (c->x86_model =3D=3D 0x19 || c->x86_model =3D=3D 0x1f)
> +			goto mce_broadcast;
> +	}
> +
> +	return;
> [...]

