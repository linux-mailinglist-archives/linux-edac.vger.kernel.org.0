Return-Path: <linux-edac+bounces-2549-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10859C7FE9
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 02:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06E62843AC
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88FE1E378F;
	Thu, 14 Nov 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igYEoACo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30A1E3799;
	Thu, 14 Nov 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547240; cv=fail; b=OF73vKijj/IOzy17tGBdnW849QtQHbaKqZA4oQC9nNzUTiZa1xJhLGTvBVjtWQ1lUxp9AsyiP2tB7QThxQfbo5iQAoTxfIL+LWdjyF1bb6DjdobMEYlhpKASwG8wtdEMENcAl1MzOHw0ws1eAAMZwKkqqdPyNOnF5zAc2s5kvTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547240; c=relaxed/simple;
	bh=aysYwntix55NOvLySrythbQBljylWxc2aSG97MTe7+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmXUuHJEOpO+TMFpoPA8gnucjn4AcczrlnxYbaIrJEL+UI7/jdtcjgfnLNFLrBoD/jLnmBJOyoV18re1p7cET0bM5lZ5MOWHWLls/+XOjhqNP6+xs7r1DanTjUhcSCbKYlrMeec6a0winyochAphPO+MAMj1quGhALzmNqlq/v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igYEoACo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731547239; x=1763083239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aysYwntix55NOvLySrythbQBljylWxc2aSG97MTe7+c=;
  b=igYEoACo23YikDkUaUX0/Keqgn/SsdgAKH8q4W+z1lN0me79l4zL7VSa
   UJ0xKoeiwM/SRdJQa7Q/0fnQV+FiKG6n571hIh5+nV1+BjC2RFVcDkych
   hk+pkrkjS6o5jg/Z4Fz+baodzoc5i7vrNyjYI7Q7Z4Sp/3fCr6rNKFgwX
   zbf1Sc4ZTs8tDxiB7QOkdeDKQ9zLepE+dH6BF/l7WUVZZ4XKkhKdRl4vL
   KQG5q2kNM6OzVEn/v+PoSECHspOrw84LayJb5NqJHZeEbVa+AJHJMZ5rh
   O9abAixwuTThuQxIEfvTgDTxd2hc9gseaDGJ7o8yZ5hqJiWRRW1KSjoNK
   A==;
X-CSE-ConnectionGUID: 4QflCl/sSIqFpNhmrIChEg==
X-CSE-MsgGUID: jr76SG3YTM2r1OJeVpZuJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="35263749"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="35263749"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:20:35 -0800
X-CSE-ConnectionGUID: 7xRAZvCZTYGXYRnusoEZiA==
X-CSE-MsgGUID: Nfo0FkaFQiyUmLHJG2R6cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="93099287"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 17:20:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 17:20:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 17:20:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 17:20:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sceKVLB/RXEWSsPOnje2G4UwIXEFo/Yzgrx8Ez4hSyPobe72In0yAHz+87KRcI19JdOMJMmmQtzj9EPRzg6Xoes87XFbcSelHfmDE1KPu7mpg4g3arJ4UyTlupAvnI8oxDeKXoZ6+1IY4zSrfJK/OPdrKfhLc9AFtj+/P7yw3kiUJJ1gYbzUJkF95/DgXLI+lgxqbMTbgeZrQLhcUUIErLQPsIH6SEwhtUH1sv3MfYBF0iwePbFEsPQp6Ik73ZpwSB+FmL2i4ZiEGhfzsMxa6sGmZ7VuOM7yTkkuBeZn09ZuxK5vLHdAb2NVNS45N/7LiAf+RVXnvTaf2xsRzaDBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yreshCoQTOFPqfT/ZjmWPsDGmqWveswZbJGEr9JcgcM=;
 b=QRQq5nU0yyBgGifXYi/JqVGsaKfDaPCFTs5GXJ3ieVeYvHgkjixIbZaBUyO9hLDHtIgHsSR9vQhxkCdiOEMoVcKevCOlXyuZ7mehEJ+FXQxe3+F/e8AVeWtSTg75AmPYYQR4S3fdeDTt2HHilI9skJ1QQrrKFB3XOtU7FHYa+4gyZDmzeOYTFbHhmmSfjhGvso4DcySZkpd1OnxtKzLTYElqJHwZtsAUK8NYVl2LI04lxTT00DBx7U4mIOnfAW/pxnTvWFVxQvFN3yg5sNW/BclpgObq9daBuhubLYxRiIVyk694Wa9B+T5fo6R5qT+5sPzJfICkQekum5k3X2XmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 01:20:25 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:20:25 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 8/8] x86/mce: Fix typos
Thread-Topic: [PATCH v4 8/8] x86/mce: Fix typos
Thread-Index: AQHbNAPFEd+OSdQ6ZkCzBYbpcY5i67Kzyd8AgAB0dgCAAQsQgIAAsuYg
Date: Thu, 14 Nov 2024 01:20:25 +0000
Message-ID: <CY8PR11MB7134BD8117B9106EF666147A895B2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-9-qiuxu.zhuo@intel.com>
 <20241112153842.GC3017802@yaz-khff2.amd.com>
 <befe8002-a5fb-4d68-a7f6-1bffb97ed255@intel.com>
 <20241113143123.GC3181969@yaz-khff2.amd.com>
In-Reply-To: <20241113143123.GC3181969@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB4735:EE_
x-ms-office365-filtering-correlation-id: f5fbd53d-7fc5-4b96-2b87-08dd044a848d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jbSY/sZjGUrikRYZ2vXgIo+ukg4268qn3xrxmwJmm59gHLj9Bms9p95iQ/bJ?=
 =?us-ascii?Q?ttAIFBVg3GFX2pcpBfuWBX8lum+XbjOeDqZBGuUIvDC2/RU5EPB/JDywK++m?=
 =?us-ascii?Q?tNt8WJzv1ImhlG5aWVA/J4bonvqshfF9KQrtpLRlJdbBPQw6+nev9OZaChEy?=
 =?us-ascii?Q?FVHTh0kLaiAgu4pv+oxOfgYDEz0vQ73MnGCYVHuOoEgvqdXPWcrpMUrznyCI?=
 =?us-ascii?Q?16r2fb3wIvMKEFD4YixnU/uoRW9jo1ZwTQlP7BUGRyBHe55ccd5FeDWm79Uj?=
 =?us-ascii?Q?NZv37Gdb2MhCjGIB4rIofVUb5IBGvxq6xuz6POQWBFi31xa+cxoNQwaFy7FN?=
 =?us-ascii?Q?mgQWp1iScD017nOE9Zhuz4VvlTeL2nDflAV0iu9KAgBopbYK13zNOh5UatFq?=
 =?us-ascii?Q?CRwWQbUKlb7weg/j1lxVSQySxcHqz63w0b9SYJb6/3g/UR5TKZ/E2y2lpGjv?=
 =?us-ascii?Q?i99zGhWI6FgRbH8fhFCArpPjA+T/n0sK6UKttDOtRXbEp8tyYjKO4iSByfsK?=
 =?us-ascii?Q?AAn1rGZ0uQeLQpdpArbdMq23HrruTMXFRl1vLPtVclBnArWizk3+j7mUy+b/?=
 =?us-ascii?Q?Ye28n8uUCe69ZyXnlSaC4G80zAvB8+lhO+sLUmqf4DDcFOu3iMefAsl85n91?=
 =?us-ascii?Q?+7Mh57w7NfnfcvvxZH4UkRRHLIP1+WL3b8C+B9p3rvwWjADgc+nR8tNuD60r?=
 =?us-ascii?Q?jFIIVRcAMYpTHbCT1DnxFmkGkT6fPX4Jxsq3oMfIjS+/BRzzb3ZinmlcZhe3?=
 =?us-ascii?Q?/6dNOh2Wqi0BbS61EtMh/M9DwBCcBYssUUVhqeUvUVJLv+yiatm6JoRMxsGX?=
 =?us-ascii?Q?WTnt33KLTqiQ52eajuSOsCdS2hWq01zIiy1X/lkUFv97VFqUe9IXfZyAREQT?=
 =?us-ascii?Q?KnXgAiV0bm6Yl8crymWp5UVzpSpJkDD8Ba3SatZCSxF7sOKJOvbF80pPE2W/?=
 =?us-ascii?Q?HTR/ovezQTvP7uiV0Qur4IPkEHbSa3B3pyc9AQoUQnXphFP2a1Rtfn/Y1luI?=
 =?us-ascii?Q?h2BNftEOJTrFp71bEUB6ecjQdBZaLKHyJ62wmP7nptiQ7uP/sLQqNB09w+7F?=
 =?us-ascii?Q?sum2RH+UPbtMywilQNwFL8apmLQA8iOw9R3Yziev2h5M4NT+NTYsWDJa36ad?=
 =?us-ascii?Q?gRUawPaFmuHZQ+BxTktK2lFab8BvlcU2ZSFxwnjTLkRjQGd0uan3RxMjiHJ3?=
 =?us-ascii?Q?a0Je6RYK9oggj0ctQxOzIRmSaxyDOfvcwQSmff20AoP15x8FMfHYMwZVkUou?=
 =?us-ascii?Q?A0G1I5Bpu4vEdj0CLBpgx8UNQjX7xlRZ0YFDkpOm+TwvU5ZyAzhdakjQsscg?=
 =?us-ascii?Q?/nTgHlCKoUC0wBeEfmmEjhbPBECR+MVGidKvbu8AYG8jx/8oqK4s1Vg+Pw8q?=
 =?us-ascii?Q?ONddIbY8uESVjJb1kofY/nBDkiR2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oMgbKqcm9NcervP+Obavpf1y4rWH8pC6JfDouQePrnQsQdXimSdn3S0/U4+C?=
 =?us-ascii?Q?f/jKB4dL6vIAR9wwzbWtu7R6u+bhc0M4lXfPEKGx4qUu9o4gZ+0GQ7951ZjH?=
 =?us-ascii?Q?omIc/mS231MpmbBK626N+gyychhXhuwAtDN6FR71mvlpiwWb+D5q9TVnMveM?=
 =?us-ascii?Q?HECDgM8GpK4i+yl1SuBzgKa8V2z+18Crioo9h/pOFKNzCInCiJuXIA2y1V2t?=
 =?us-ascii?Q?mNSRFdHjbGuCdfi0gDxNLF8SBFwLQRQSoUrrcpIKdrjEUIU8iN79dUs5wFNu?=
 =?us-ascii?Q?gSXjfUxncJRSJKHju2JpUL1V0apB/IUWPW4EgfvRdv+itvVh7SMOpqRVrrNf?=
 =?us-ascii?Q?sz20mQ7IwCHyEKTmRCKiWnHFyvzp6P8yxmJ8otAlL/do8HotoQlDROpKSKow?=
 =?us-ascii?Q?o+2jkLAApaQhnoksoy5jmQO0LC9EXCU0fn44r04CtNCf7kb5D5dNOVIbZDu2?=
 =?us-ascii?Q?yjk4AvPoVl8xy3J3WukMMtHN3mp6D3IbnX9FITEz/qjRZRN3eiXo6QHBgR42?=
 =?us-ascii?Q?i6peG1JyMWSKz+UgxtZWyil9pPbgo9odhSvAVAbg8sWB3sZ+F703BGgNiKUy?=
 =?us-ascii?Q?3XMSlyM1VlBVq9co61/rgTfCYQLwFJpPd0aPA7qbkYz/LN4CdHQFyiU+pluU?=
 =?us-ascii?Q?H0E2hv4oC6W1BlVfUPqI0SJ9H/W7rxqZxj5P6Qn4fJHgo53NJxTVfKBABZoT?=
 =?us-ascii?Q?efQ4qo4QqaX8LAInCBR9zoJLD3HxZ4OWi9pf4KUWbP4rRmQU0EU6CpYsbMAS?=
 =?us-ascii?Q?/MiNwKwLWz5Eik+/uQaGSvSqy/xPa432sba9CjBQtLRjfpYCJUHvtVjUQdrf?=
 =?us-ascii?Q?JVMbCGE5C54W/BFdAzGqSliIOR0GukCraAkGI1iW0LRB2YITGZUhIdf1W52z?=
 =?us-ascii?Q?3ciTZ9BNHHMPAuDgy7Cfw97wyg0ZZSsWiYE7q54BVHUIAHiQdSqy7uVXo9Th?=
 =?us-ascii?Q?IDGZ30jpQL8iz2wdIbvoPGfFDrZ3kyUuq83CkiembCpCjXv6pi4ryezkv/X8?=
 =?us-ascii?Q?sn8bROvC98/Etb/9X7H5lYcgEMkA1qrgJXbx6GCMtQP2RJTUqS71nd1xpe7f?=
 =?us-ascii?Q?Ti6mPZqcCncUeqm0OCG6hktTME8Xu1SfHmPMEnzIgli+LwiVaFEnxnuvZh1D?=
 =?us-ascii?Q?HLU2SMZuFzkUN0KH9IGnDdvGwwFaQr3b112+qabZ5hosjwM9Nr2teKcX4GUo?=
 =?us-ascii?Q?mbbYmrfr7tEZXWRtOV8zs1eCapCys1VHtMYWNSvTkdHAQgGfYH3d31Xpq/3a?=
 =?us-ascii?Q?F0Qc9JIxSNJ6LAEmwgFjbS2Ul23gfF5euGbWgP+X3eWLHYrMNDROUTntRInC?=
 =?us-ascii?Q?lpIIvzhfhnp7ij8gpJvLTbyArcgefulF7CZJMRwRx0s6SqWPrTZ3Aofij3oR?=
 =?us-ascii?Q?GagQxwE6nwxcFOQd13tscf2cIJUQnalljIsMm8Rh1ZdBK+7CqlCzhdWvVZpr?=
 =?us-ascii?Q?0nkEV/H3BkAU0XSQSAsS33t0kOlWnfuBPT/IXKyGpWztdmwzrKY6jO3QUUio?=
 =?us-ascii?Q?Tk+WD1eLRKb06lNfIh3DTOf5sa/XunntwmKQ+ndWclb+XfCaM3yNwjyZjR5k?=
 =?us-ascii?Q?mN1BnN/8dyZ+c++AIrdjyAl5VU1+lRrWfbB8Kz6Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fbd53d-7fc5-4b96-2b87-08dd044a848d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:20:25.4310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXiCoMWDZ8TYpMVg+vJ962rz9Fki48o7dzPLdKT5+lNXGimqQ/7BWht5jhC9bVVsfV4eQH6FdjLyyhdWN2tjhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > >> -		 * disable GART TBL walk error reporting, which
> > >> +		 * disable GART TLB walk error reporting, which
> > >
> > > This also is not a typo. TBL -> table
> > >
> > > From old AMD K8 BKDG document:
> > > 	10 GartTblWkEn GART Table Walk Error Reporting Enable R/W 0
> > >
> >
> > There is another comment in init_amd_gh() that seems to be related to
> > the same thing and similarly worded. That seems to refer to TLB
> > instead of TBL(table).
> >
> > /*
> >  * Disable GART TLB Walk Errors on Fam10h. We do this here because
> > this
> >  * is always needed when GART is enabled, even in a kernel which has
> > no
> >  * MCE support built in. BIOS should disable GartTlbWlk Errors already.
> >  * If it doesn't, we do it here as suggested by the BKDG.
> >  *
> >  * Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D33012
> >  */

Thanks Sohil for this reference.=20

> > msr_set_bit(MSR_AMD64_MCx_MASK(4), 10);
> >
> >
>=20
> Now I think *that* is a typo, since it doesn't match the documentation.
> :)

As Yazen has the documentation that says TBL (table) is the intended meanin=
g.=20
I'll drop this patch in next version.=20

-Qiuxu

