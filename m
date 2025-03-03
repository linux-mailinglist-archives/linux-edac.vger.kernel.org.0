Return-Path: <linux-edac+bounces-3250-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56023A4B647
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 03:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317F516384A
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 02:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3B19C54B;
	Mon,  3 Mar 2025 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBmsDBHV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00687D07D;
	Mon,  3 Mar 2025 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970389; cv=fail; b=Lw9oudB5hoqRwquudxCL2tZLa7PX9h3I6V5oClMouBTu0FfN+66lqJHyC1mq9uaPlR9W8lIp5RNo8NMC1IhY3s4wJSgt5sDZXTLWJJp7mh6VgulPJxlhAo23n9zHIvo+YdKMCbqVtWfb/tyhuoyI4AToixwrEQ1VMfxKhHNozTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970389; c=relaxed/simple;
	bh=IAyGhF89K/SI9rRp13GB/hOY201k5DQllzjqCT6IR7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNXyTcg5Qg241397sCLPBjF2D1lklzT5IT0HV1P3QifrZ5CzQIxBv+KEb0nohRrwZmkbofPxP2K3Zas2BV19ScOJ95So/dHI5WxfG4oFUKdx7jcFVQZvKq+L1MoWcKS7MgDlkgI/aVFUNc6PIIaXspF3DZWIDGftV1gGXjUxbC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBmsDBHV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740970388; x=1772506388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IAyGhF89K/SI9rRp13GB/hOY201k5DQllzjqCT6IR7I=;
  b=eBmsDBHV8yhIFvewJnYchHVU5ihzuhurjepbNJes5yfUvWKn4+EOqemk
   Hm4IVBeJ3Q3ycbWlI+7lXQB/ZsCQ5iLBXDn199/yESA3vMA0m7CIaVgE1
   gw5xqeCFFTzcsfHgQ45SjuC9ZwrH0bdSLgHRqe4ipsFMx/0tLKAlUhVWa
   nHW550WXW3mMeuLzQx3J+XPJzUsIPHIRynugyAKWYEUSliN/0rN7/b0Ey
   rwr+Kt7xi4W58EUhQ/YMmmbSV8dogyqh8mQaeEQdmdjx1zsIzhe8N3o0E
   CpEpDA5rRrMgjxs4e9WlAIDrUdQ6M+FZICyMwU3x60OI6KqrZDrPB08su
   A==;
X-CSE-ConnectionGUID: Lt782eJORrKZ7ULykAUqHQ==
X-CSE-MsgGUID: EYoW0+B/TVuX3j/HkIx2Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="44645747"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="44645747"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:53:07 -0800
X-CSE-ConnectionGUID: LttTVxqKR2iCRnHRQPWy9A==
X-CSE-MsgGUID: hlKzmqhVSOqPltuYXnF1Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123107114"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:53:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Sun, 2 Mar 2025 18:53:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 2 Mar 2025 18:53:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 18:53:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MekH95gj2/1xrg47TjjignJ9YCkNRxDhrjiBdP5rpquXWywNAFr5xlVENHG99OLAhvW7MleSU+9qc7VmOFb673VyKUhhsRfZGgtwCaLE+ZuYxFXIYK2VkO1Ov2bmv+XqkGXTsVGOdvZXhEIPCp0UQuxU2dN3IUuoD1At8mzy8XMXqknPY7gkj0E/xceKIaZ2mTR1tChHnlLYCbSen1zIWSHRVJxOucv63PlOFYWLgaebD6a5cLx/ID2bNDDnwPIeBTuAVfB/YxUQ97IpzqRngdSC7klczsDfqp0p4Hsf8rB30bdXI8Rf1veXlH2K7JiLW93HQ2F58c4AdARlDx8Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7j+81fL6rIja3ZTUfeRYViswdn/+IqH1TrQJc5nP3M=;
 b=c4T/jbiEpcCMAu7XOlsI3R87VDgQOGHdmae+MC3gK606NQHKNTq12r7A0LAIT+yW4tPqAjhxfwwvZ4+1v1nYiZ8IJTSLkjJ4ATld6j7XfcIkO4u/lWW0O8ehnFumzuR0mgyfuuS4aeHsff1Sx8o5k3zUN/573t641bPiCbKWReP0K+JtZbqEgEyu/f9gFGesMv3QlRXkAEA4P8aUS3jIpQ1m9FelGGpOV0k6FGQjXUFkcu3zc0Z0JOek0d/1QLwOXeXGHUiQmEZZ3dQHJ09h2GjAJdb/2xo5hKs9pfS2GSDX/FOHbXcWLqO0ttFSpW5w0GNKV03SCiQWyWtsRX+XTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 02:53:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:53:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Jason
 Baron" <jbaron@akamai.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Wang, Gary C"
	<gary.c.wang@intel.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/11] EDAC/ie31200: Switch Raptor Lake-S to interrupt
 mode
Thread-Topic: [PATCH 11/11] EDAC/ie31200: Switch Raptor Lake-S to interrupt
 mode
Thread-Index: AQHbh/MOMRhqJ2yjdUaxCGzG+stTJrNbc2IAgAVG4aA=
Date: Mon, 3 Mar 2025 02:53:03 +0000
Message-ID: <CY8PR11MB71341E24E4E30369757026ED89C92@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250226015202.36576-12-qiuxu.zhuo@intel.com>
 <SJ1PR11MB6083A8D348C9DAB38444B2EFFCCD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083A8D348C9DAB38444B2EFFCCD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB6621:EE_
x-ms-office365-filtering-correlation-id: a48ddea2-cfa0-4e01-30f6-08dd59fe849d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XILAn9RaJlI47f6h8Pr/lDB4D1OdaVHMSnPGT8qu/aA85p92cz+F4lCAmq?=
 =?iso-8859-1?Q?S205bJZZt1p1yS9RkEGVz6Qy5VnBoPBom76nUAw7u1Hy8JR4ruFdBWAb61?=
 =?iso-8859-1?Q?HfEfTVMXa7tv1JYDU0hRN0u8gZxAPUxvSPMmqjGDvFLmA6lac9M4I1t7oV?=
 =?iso-8859-1?Q?TF8K0BzL7tEh6gEko/5zaV9+B7mPfmqMRKoKZoQjr8O2KSpL+GE8ZFN6iP?=
 =?iso-8859-1?Q?YAmGByxakFEsCffHtUxkAKGAifEUgZtLIi9Kud+2WyaK7XNSk5LqTATVBM?=
 =?iso-8859-1?Q?QCEZqzNfQHizj3WHsRqpiNl760AhFrt+e6ZJcby2n8NI1FQCvuXwpRpDnb?=
 =?iso-8859-1?Q?aQjZDRK3+l9oZPDmrevRJaAyTGk1IQNvveYxcwg/NsJ/pBUG3p5AQhdqf2?=
 =?iso-8859-1?Q?jZHjr9UoD4+Z1SHChu9dA6td+fqwgnLskm8aq0iQpomb4J8B8DTZaQ/WU8?=
 =?iso-8859-1?Q?7cLNdGPrO6mY03x76CGxnVwpgW8xTFAs6XLUL5hUp+2xCWgI49+mu6ggNy?=
 =?iso-8859-1?Q?pPFfvdxOWokoiCA6SgOh1XIh8voqaallXYHQK3293nD6ahCBp7vU+T+R83?=
 =?iso-8859-1?Q?x19BHCzygTa8dJiUi8KojfiuDhpXylB/8YZiMIvWHYFhTjbslGL+IOhTlW?=
 =?iso-8859-1?Q?WfATXuCAiQkAjk8UVbp3hp9WifexAJoFfzzEKGhk4oU/XsRDfsGnVz2osU?=
 =?iso-8859-1?Q?vhOG7sOSMEK5bnwLnxlbqzBpIg5r+0TsAnpZvPKP45Jq9S3scUD+mTh0Uv?=
 =?iso-8859-1?Q?K56cBaDZcXpvVX0ah/QgXLvK0fhIMUiWgwTCCr0dh0Q/t8lst3Md2FNCRd?=
 =?iso-8859-1?Q?yNagSO4tGIo/nnwBDLcTXfXME5USs33m+VraAMWLND66k2OfZ/j8Hh1pjG?=
 =?iso-8859-1?Q?hNfg98yPO65ZTXeM2niEfGEjlzGNBLPiEXKAq3tiRfxf+WZazati9GT4hG?=
 =?iso-8859-1?Q?3hsB93Lntbicp5kwZugTAhECuCdjnWK2Mn5e/vWxS9lXrMpljYv3iNul/3?=
 =?iso-8859-1?Q?33a4SsSGz4qs9hilDDhiAWPB3raxszlt4q/KoNxnjLwwgmTtIdgkeH+GB6?=
 =?iso-8859-1?Q?l6Bm4Jz50CkuMkTTTq81DN0fABmv6hZgcrzfAMip4mbiXrV4BBgFMX98Pt?=
 =?iso-8859-1?Q?+FFz9PFwqSsEgYiEUQTCreLNA6M6a2O5xgRom0f09dknELI4EuPYi4CKoN?=
 =?iso-8859-1?Q?qlz6DPFCzHZxb+vs3SEj4s43vRrESXL3cUvFYWHTzGP2M5/lkSWiu+RLW9?=
 =?iso-8859-1?Q?32YUgoPt/8hShbdAfR0TwjVrWelB1q7hHRflKaT0Ywt5N9t5eIre5nC+R7?=
 =?iso-8859-1?Q?ogVv1DF2JTbzr8roC9vJlrnA3bBAoSju5AQHYYPhKtAB8rRVoVAroTFwb5?=
 =?iso-8859-1?Q?+wv43VCy1JOxW1cyCp26bwXlp0pjL7p15LK9qlf3j7ZuMoy8IiBsoMzAYw?=
 =?iso-8859-1?Q?22eGgnzuNTHtZ4TacIm2cfgsauaC0eQ7zyWS1DiuVQRtffMrK+jmbFqP9V?=
 =?iso-8859-1?Q?z4BKHLCb/S5SzY8vnCUhS8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?InuICbxLmJfS+8dhRol6rV8OLxKOAv+NuPkjU28M/iUM09zAubfSvN4jkR?=
 =?iso-8859-1?Q?vNrR/RT+BTLFnj+8ekIa3ek1Yhw9yzyZ+RV+bT72IWWCdyjdUnO0MWsGaf?=
 =?iso-8859-1?Q?HV9I1Ugm3laIH0Q0Q2EA1DnmEpLbXjUnqP98MIjsxCHDrHNXFzrkxu6KxV?=
 =?iso-8859-1?Q?RhBOyPW3X3O3MWThRFpsO9/jvtGuNAVKu9ZVbHc/itNs2FVpXlMYlLz3AV?=
 =?iso-8859-1?Q?8bTSeC9glB6Q+ZPkkRQBQjHBpmO9fgpXVJ7TE+rB16T80l7NgNoTSogWjj?=
 =?iso-8859-1?Q?4u61u3f290X+T0V1GE/8Wplwprxw6DnJekLxqcueT020mSyQEL5dLh1kcQ?=
 =?iso-8859-1?Q?DF3/OuSRjJzRZzplHZqjSUp6R9Qq6qU49AWbWW+1GxQEpGHryB1bmmQ/a1?=
 =?iso-8859-1?Q?Z9onFu9xqbp+mYV7WmtblMUiX3oCS7yLrfoV1aVCLCXeaa7jUNmdyiWXFK?=
 =?iso-8859-1?Q?b48MLHAoM0iEUm3u4pyKD5dnn7UQYgkD5s4bSljumIQJOzCY/nufJRwzCS?=
 =?iso-8859-1?Q?cgAlo+PMDky7oCPeztkzQP4cOHQvNCCmiEqtBz2grWq4N2pxxf9/bBbL72?=
 =?iso-8859-1?Q?6THgkQycH4b6h3sIbPpnIQmPq70nhum3GY85pp6uETfD276spx5GuIPG1r?=
 =?iso-8859-1?Q?GvxuEsl552/XvOUOu55Fnl6e4DNjV13OyWZgOhnXaP3w+5ggi+F7ABaYEf?=
 =?iso-8859-1?Q?uX6vrOwiRn+Zo/LHxUzahQ057kiAZ/LPF9ssZRli0tloIHKMxgBuM+N0WZ?=
 =?iso-8859-1?Q?8LoVaE86NtlUsewr4HFDUr0/2Aep3lEvETu6DYx7Bf31uPfka9zl5+pQKX?=
 =?iso-8859-1?Q?r3ErjCWGRYkotzUnFQhkD+xPM3PryRjN0OuEQdWD7zYzU2nnOr81JnKJWP?=
 =?iso-8859-1?Q?5uJK2fSGhqUzCE2xRzPG9COzg4n/s/a4WrV+EO34yxQ9tHsHNPWqISq9Wd?=
 =?iso-8859-1?Q?AQQigUWUhMromMFE3T/Yb3w2ueBrU33R1gyW7Bwxdv54XHQvve1QF8n62b?=
 =?iso-8859-1?Q?bpnPk/j6zt3O05eq7FlJq8vtYhmB7XaFCTQdJScrGcAE/iZ39RUcdYm9wl?=
 =?iso-8859-1?Q?IoOp6hWJeLL7/J+1vRfFsrcvt++0JB/uvrO3h+peikgbQxwYlvBvhrISBA?=
 =?iso-8859-1?Q?+0GTAe8sH242QwDt+TvsYSFs7g6mLVKe//AWoQHZpHD5pgUnERSe8AG6jA?=
 =?iso-8859-1?Q?kEtavFI08Addnk4pdOdRa6C88nelpdtGajMQ0JzVPE2tPEo8kXURK/zOiX?=
 =?iso-8859-1?Q?hvszImhz5qcEGaAjqXkCKHCPSTzV7ZD1ZDrsX17M1DBGNxK8C7viTL35oR?=
 =?iso-8859-1?Q?YyThd6vYA2OFMTUaxbUrzVwLqzSAGoRZYmEDwpVi1v3it84nuvMll9feVZ?=
 =?iso-8859-1?Q?HWmTn5gb3Di2uPAX3JtVmitI/F/QUS1S7TGiNBgNipieRdtilpNT0CUW09?=
 =?iso-8859-1?Q?tp1w0XCnsqOzg2s8Lggof1CNeY3YPsPPNDWXEW1KMjA/cz65nAZzbI2mLY?=
 =?iso-8859-1?Q?+eJ+4DTdgNSt8Lt/jFqmuU60B5jxj8Fri7tPHWLGi3S2BguYejM9Pcm/u+?=
 =?iso-8859-1?Q?tKxCerBfF9beYLV+tjDmdi5YZgmWcDZDLeQewD8gP98mHbzDRIMqJeNV/l?=
 =?iso-8859-1?Q?O1ZoWLh/u2MVpFG3ULBSMPT9I8PMfWt0cH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ddea2-cfa0-4e01-30f6-08dd59fe849d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:53:03.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RjPbnz8xQ4ZM6SUKPVwHPNoN+Huqi53kpGceUYAHxJvF/xMRhNo+GiAv2i4mVbWEF/bJUzVlyGcSnDQAGWX9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com

Hi Tony,

> From: Luck, Tony <tony.luck@intel.com>
> [...]
> Subject: RE: [PATCH 11/11] EDAC/ie31200: Switch Raptor Lake-S to interrup=
t
> mode
>=20
> > Raptor Lake-S SoCs notify memory errors via Machine Check. Add
> > interrupt mode support and switch Raptor Lake-S EDAC from polling to
> interrupt mode.
>=20
> Is this notification #MC (a.k.a. INT#18)? Or CMCI? Or #MC for uncorrected
> errors and CMCI for corrected errors?

We performed correctable error injection, and the correctable error events =
were
notified by CMCI.=20

> Corrected errors -> CMCI I can understand. This code should work well for
> that.
> Same for uncorrected patrol scrub errors -> CMCI.
>=20
> Other uncorrected errors -> #MC is trickier. Does Raptor Lake support
> recovery from other uncorrected errors? If it doesn't, then this driver h=
andler
> will not be called (Linux panicked and never called the functions registe=
red on
> the mce decode chain).

It seems like Raptor Lake doesn't support recovery from uncorrected errors.=
=20
When performing the uncorrectable error injection testing, the system hung=
=20
(The validation team mentioned this was expected behavior).=20
=20
>=20
> Which is perhaps a long way of asking whether you really mean:
>=20
>    Raptor Lake-S SoCs notify memory errors via CMCI. Add interrupt

Yes, the correctable errors are via CMCI, not machine check. For uncorrecta=
ble errors,
the system is hung, and no callback to EDAC. I'll update this commit descri=
ption in=20
the=A0next version.=20

>    mode support and switch Raptor Lake-S EDAC from polling to interrupt
> mode.
> [...]

