Return-Path: <linux-edac+bounces-5572-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51904CC9EB6
	for <lists+linux-edac@lfdr.de>; Thu, 18 Dec 2025 01:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8923026B1A
	for <lists+linux-edac@lfdr.de>; Thu, 18 Dec 2025 00:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3AD230270;
	Thu, 18 Dec 2025 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgLIoadc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6095225408;
	Thu, 18 Dec 2025 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018675; cv=fail; b=n2wvNFmxkkQc+Kjq0PyskBrTjIUR7eZ/0mhXIFqo5axjRYyGVy8A/cnEALOGJI/clqey/tQuJCPodB7GGlUPocVnPLEuSQsfF/pnYlqLi+9VcUSKS+c31cFJHEh/kCIOa23lwYxGla1CiqNUW4Kgze6X0dRjbcKrjBxiS1QC5A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018675; c=relaxed/simple;
	bh=7Gt2S6h+muhIJ+iMXuJjluVs/TMkUQA4ZqnwOIo34OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyvCIHaQgcPdshp99Dt161G/dzBn9jjhGh6l7QiTh6k9oMv5hCgN5TD01uRxssyaBx4IkuSriSA0jjfQ7OflBw7nLnq2/9eoc/JL5gjOAPsYhOg4aTy2tCewpxRV74A0ysGMmmXkw8Hx3K0JhQNUVWjb1l47sgw5tK9MiZAdn50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgLIoadc; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766018674; x=1797554674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Gt2S6h+muhIJ+iMXuJjluVs/TMkUQA4ZqnwOIo34OE=;
  b=FgLIoadc4Ju2T4UJH8PvtRtDVwMScHpKvIo/mIVnyzLlbeBlI26OL5Ca
   8HN0NZigVbywb/aJMMWktU3GJQaDyTnClus4WIZdqep+DP08yqFXwb3Ca
   wDB3n6a0BpSWXXlE4N9Lv94JH1XqySmzVOq630fcay8lp6vkcD9rH3LZN
   yt8FQWdI7Y9BYzKO/Mli8n/0jA29mP2Q04PTrpqDLDXcAJLasf4R1DExL
   Xb4sdQAnjF1dePz5s9mSOH0HSgJWBR21zBVNxo623+QPYa7c+oidTjsIy
   D1kfi2b4cxPy5+e9XFs0lemA6/UopNHuTinpxOO3ljjWIr4GDL9/PZ22s
   w==;
X-CSE-ConnectionGUID: 4z+3EGmrTKGQo8Y3Rwh9Ig==
X-CSE-MsgGUID: wCvuAgVyTkSM3c475lQvrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="79337346"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="79337346"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 16:44:33 -0800
X-CSE-ConnectionGUID: aRSUY62zRE+4Omd970Q9cA==
X-CSE-MsgGUID: Z1CBsHa3TLa3X+pip/fhCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202947287"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 16:44:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 16:44:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 16:44:32 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 16:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNuo0kL2O0GA7uJBu2p8wQRuDy0DLZKjvXg6HAlxPYontt73l0YcI5LMfPZqbZYFDnZhQX5BlQZ92/ExoUFZkAcVJzxCf7YT1MzwXnTRGYUshGsuz1zhV6+XBIBX1U1CmYLyBX5HwwbEAbU+5oiLs2CsC6Dy5kM8anvZZn84mcVn/RP5cKsQUpQ1JH2evG6nZUwIIZg6awbK/rLf0vI2pOiFDtuWNnObU4Fyh6saTkfDQpomBQNUfoFXUvh47cmK1N1YzLOgG/Zww2pnBA6DJ6iCuixs4S+rDtcxnHiIVkqdowLFw39iQoBJhFWWCQfMYF5mQI5F0MfLEc6JjpowNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ka30PgiPPU3OuiQEm/ipqkxEMZ6Q9EAsN00UL09C5A=;
 b=b+4ivSeZr1kbCYGPbw2vvnD/B6E8Ix7m0Qcer5PdtndySLAj8He5LDLumH3KiTBOx5WlwQmMgqQCmjHQTCLwik+v7JkORywgM5C1BgkZTS6eIvkdqDGtEB1P3VuTruiPAq9ClOibZO9oOBhoIEfanu2fVFL7UReQ0f1zveFdTImymZ0iqf8RFqjrxTGwHEj3C80Hnx7urEaX1RcfdudsV93EucVAX6Q4btRufGbZlRwXia6YunTn9KCfQZgC2eNuQmLOtQTESXWUrZP9lYKMXs9vf3qozHoFOYKEjzcUcguK3ZbNzVvNmfn2dlkaFJSagLlujH2jXlhmcre+ZVGKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA3PR11MB9463.namprd11.prod.outlook.com (2603:10b6:806:45e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 00:44:30 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 00:44:30 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: Borislav Petkov <bp@alien8.de>, "Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"Lai, Yi1" <yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD,
 ECC_ERROR_LOG} configurable
Thread-Topic: [PATCH 2/2] EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD,
 ECC_ERROR_LOG} configurable
Thread-Index: AQHcXQ+uRhJRBbUzPUy4yi5AyqlwRbUmSR4AgABooQA=
Date: Thu, 18 Dec 2025 00:44:30 +0000
Message-ID: <CY8PR11MB713473676F8A72C759A843FE89A8A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
 <20251124065457.3630949-3-qiuxu.zhuo@intel.com>
 <aUL0FlWTViEJHOKi@agluck-desk3>
In-Reply-To: <aUL0FlWTViEJHOKi@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA3PR11MB9463:EE_
x-ms-office365-filtering-correlation-id: c3f183e6-69f5-4fb1-f7b2-08de3dce9b0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?k1vJkVInufWyMC7mbYNZQg1IEUI23eFeENj0Te65iyuhFpGaHlOizCb3aodA?=
 =?us-ascii?Q?FEPZYrYH8kDuJh5F8QIRKEzv+9OiUt5K/5ZkQY3xIDhfu9L9NmaP1yaYF5Xj?=
 =?us-ascii?Q?5MqqgvJt36wOV9vw7hreqxEeXAaOx7HpaouECx8skpcQ2mKeR7wmqTblQRXH?=
 =?us-ascii?Q?lVSDU3tXWghR9zDjtSqkG8lhhzHSCK1crybwO1qbmWsKSSXe6PL50r0tj0FL?=
 =?us-ascii?Q?6EP/zkmm1XTMPMqP27xdDoSHGQYb6DUl0UOgr8Hepomft7U2Y7yhFh6dW1JR?=
 =?us-ascii?Q?DnWkqth32QdWX76w5ivLqmkBAMCc+uEOefQivrdf+6I5Dhn5oAGLuhkEI+In?=
 =?us-ascii?Q?B4yQOTLKtkslCevYOFovLfgqaj1daEuj4vhHYm/h4rfscHgBRyeMjv3ChX5T?=
 =?us-ascii?Q?owdTNUpEbQTgp5viPqrrQInSEXbl/JWjSNCqURF+1odAi7m+n8pJ51B8FJ19?=
 =?us-ascii?Q?4HuVMPcH4u8j5Qc0bXYI4Wv07hp5DtNtuyhojHgbDLTuQonEMu8ys12h1AZb?=
 =?us-ascii?Q?co2e/4Mdstc0jBAf8oJjxCV9+IO7DZdbeTBIhhjgYfa5tJeyDE6GNSEoGL7l?=
 =?us-ascii?Q?ciNsoP6bugE8eWiM2+FdKBfMWtvDt7b0yQQXucWwQlsx63gPW9SFYmm5Ddyk?=
 =?us-ascii?Q?fSAWzqdZRGF3Nqvr4omFiVTJ9h4QhpUaGQnzehHPXf+AeSLtuX8RirnycJcT?=
 =?us-ascii?Q?EZ1onbjssonzZB7QIs+o/on+EJPtpgyBzjRVe4/J+LP87C00ztQBZq1OxV/5?=
 =?us-ascii?Q?tM1aQX2IS/HBTlhoYfLMtBiE2if3PdZXBePLxzXXa2INcmoy/iqpEstT5uQx?=
 =?us-ascii?Q?0hMPBpK+wBCtP3zN5feYKHc2Hj6h53bX9e4qekr+XRqUQBdU3v4hLPcna+/8?=
 =?us-ascii?Q?VVq1BpV5Zn8hNq5abgsg8QxkcqzLuhXqFA1WI4LvJ+JOJm1ZA/8sldIeT38w?=
 =?us-ascii?Q?FVdd5Z9fJY5FQSUH4dvaCP9Y+G8cAtBwgh2+s+3dzfX64TwnopJtQzIHfYdc?=
 =?us-ascii?Q?CHWkQgRQ0DDTaqE9RS/2kLfxSpv5Uvm5j/LORT0qlkiewheOU+yNxGUR/x86?=
 =?us-ascii?Q?CRvvoAOM8FDsfPYuqpH65BmBLNRD4VHHm/lC/sH1pNHf4ry3Gn66oFLVZOk3?=
 =?us-ascii?Q?uu877Inc4Zw69LRm4TPZBwVXRtiH+U9QpGzmKxkApo/pfrGZGmctcaODMTdH?=
 =?us-ascii?Q?fYCkBwbTcb5pUVFK+OseFaQ1fGtTnN4N9awe+YwzYY28a6fC0waCyCJd630m?=
 =?us-ascii?Q?PBqLl1GrLcsOcpPO8KbG0Se0sy1qbCjAG3gJ6avSoFdTxjfQiQxCiMz+tMDA?=
 =?us-ascii?Q?em0KlGSh1QqsRlZxw5TD4Lah36IdVb/9Ji/b6mD0Y0QGkpr9dNviUxt6kxVq?=
 =?us-ascii?Q?2xMyk9ODbstrLzaJv8ku9SjNkR+OHdJsojuM/ERMu/FYu/15F0x3niTY+iS0?=
 =?us-ascii?Q?GR5l1VWxITB/Yu4EA3wv7lTBEEgtQ+sz0M8hGcqJX4Tl0+MeLfnaeb+9K8+y?=
 =?us-ascii?Q?x/VGQFs6fPCmZB9nE+FaN6KuC7GpIYaizDjF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c8+AkOZzAtkfV+OBJEExPnIzLrXEKWk0D+3ZUcs/3CPJITxo9M8OpZiThbMi?=
 =?us-ascii?Q?ezCqOHynL2olARbleuGA2gC8qattncgcpdFKOPZBPWo3T839dNfpZpgtLv8K?=
 =?us-ascii?Q?oWmldv3aA/M1bRnUBSxpZylgdglRDxFs48LQcSlKuRz41iqwkyMFl2LpgUFx?=
 =?us-ascii?Q?UglU1P6eNK0qn8ScOPUXWJ8KVHtSxFfUWq27WO1QFL0NlowTuMJnfNl5IzFo?=
 =?us-ascii?Q?xvHLwDK+byD6fEVSfDv6vgyzCvSLhx4YnKNOergagxA2U7Bt6Km+e3ILNrQ2?=
 =?us-ascii?Q?iWGIAcOCxcqYxILeT9a9LtAVLvpHxpy31rD8nE+8Ry8DesN5xy/ZY/Wz7d9O?=
 =?us-ascii?Q?nMwLTUVpbN+l+gQvX+AJZlTz4xkBJOSfrK17AGxdts8l37ga/Sq/rpZ4IegW?=
 =?us-ascii?Q?/hwI6EtLz34ybuYUpI9OT8QYhHEzhKqk+oRtqmc8YACm01llDlc8WLbkhohL?=
 =?us-ascii?Q?Xfy6iDm6StIaKxPpWzyUtKpon1rGcRUJNl+XLKLcrvSRJygC7a0nUJenPatO?=
 =?us-ascii?Q?IdIIw+o8Jt+XeI1eovWkq74H2Qq1Te8vcdIV8UOS3d6e7TrGRLsv01jF0KXp?=
 =?us-ascii?Q?l85lJrR2izQMCx7uYg1bxyiZ59PJUH7NzVU7YakyULqfwagr2U03ZUTBBDcu?=
 =?us-ascii?Q?FWJh36yIqi1izU6ISmsX+9572YTXPomcCY2RANwQeTFoxUzXvH8gxhB1vygN?=
 =?us-ascii?Q?paUN+Q+5ZOKWyT/fZ5v+yR6n7lgdtYQicWPbnpe5kWWt65WTNC/Nr72rnSca?=
 =?us-ascii?Q?2UK/MbNXOzkFpq2zL2IvSr2wxuojjgxE/fUYwBT6qIwU35fFiEoBDmlGe2GF?=
 =?us-ascii?Q?5302Sf5a4gcbmQOT6sGMQAZUa1PBsPjb0B5jIFi1G9qIOOotGa1kyxafeuex?=
 =?us-ascii?Q?4+ZWazaiFuX5SRWttfVBawlzCwtKVYwYDFUdv9BgTY18oGVqOJCyqhDkR3K5?=
 =?us-ascii?Q?a/WO/JhWj4bxzfu3WO/1aQ80D9nIKqvSmMZRmpOr6Qae2ulj9fxh7sBTp7/8?=
 =?us-ascii?Q?PUYy8FC/KkuXg/SBDKmcFwbNZc4FBk2jxfGQ+bWI00HQCuPZy76tySbbV7gI?=
 =?us-ascii?Q?b8JC2Ivmqjk1bRf4TKdx4lfK0BsSUfAhcLTYPQw+J/AxIglgTEEsZLBoaZeB?=
 =?us-ascii?Q?vX9A+5pwaLs0bygzJUSM3HR8riwdLyGbeC/Jmvau4KQARNN5J/+bBxPTWefo?=
 =?us-ascii?Q?KBKLRdk7r7+HlCJ88Ok+8r5TpBVvCBC019azW3Etncr2Jm9FFIwTsmvMV+NH?=
 =?us-ascii?Q?Ja/fUDQTdqg/ckQEHBZuBlUi9GlPway61JjRgZs43xn84UiA3IjOF5k+0Pkz?=
 =?us-ascii?Q?uxuVTLNIDaN0Skn2Tl7kfoPpEBHRG1dQ7U2oxssvP3+JB7B8jk7pOpAmPHt/?=
 =?us-ascii?Q?xV0bHqaPHb1oB1/2B6U0eG4BRWS6nyrQM6FNTvcqPsRu6u17a/txP4JrD42N?=
 =?us-ascii?Q?efnqn+dTpzlvpBHFkWa1jNZifSktBw7pGZFLkEdStyhlGfY1ooJ0UJe7jhoF?=
 =?us-ascii?Q?d3uBJgMe18d3Ci7CuQIi64+2tAms4qFjXT5tuZnFOuuoSGfmujvJq5+/qGdp?=
 =?us-ascii?Q?mUFAwU8fAZWxgL5cbPMEq/yrPXpMzUUAVKfMidOY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f183e6-69f5-4fb1-f7b2-08de3dce9b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 00:44:30.7119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUQwmX21OcQoswJOMsTsI7cqLENfaegIp5jSGupqU9e6VWFoEZvY7JGpexZ5ApDmel/FU4ueyXugVaGWSXrXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9463
X-OriginatorOrg: intel.com

> From: Luck, Tony <tony.luck@intel.com>
> Sent: Thursday, December 18, 2025 2:19 AM
> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>; Gao, Jianfeng <jianfeng.gao@intel.com=
>;
> Lai, Yi1 <yi1.lai@intel.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD,
> ECC_ERROR_LOG} configurable
>=20
> On Mon, Nov 24, 2025 at 02:54:57PM +0800, Qiuxu Zhuo wrote:
> > diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
> > index 5d887a3115f0..db4aa9f581e3 100644
> > --- a/drivers/edac/igen6_edac.c
> > +++ b/drivers/edac/igen6_edac.c
> ...
> > +/* Non-constant mask variant of FIELD_GET() */ #define
> > +field_get(mask, reg)  (((reg) & (mask)) >> (ffs(mask) - 1))
>=20
> I applied to v6.19-rc1. But when building with make W=3D1 I get this warn=
ing:
>=20
> drivers/edac/igen6_edac.c:125:9: warning: "field_get" redefined
>   125 | #define field_get(mask, reg)  (((reg) & (mask)) >> (ffs(mask) - 1=
))
>       |         ^~~~~~~~~

Thanks Tony for reporting this warning.

A global non-constant field_get() helper is now included in <linux/bitfield=
.h> from=20
v6.19-rc1,  so the driver doesn't need to define it locally.

I'll remove the local field_get() definition from the driver in v2 to fix t=
his warning.

-Qiuxu

