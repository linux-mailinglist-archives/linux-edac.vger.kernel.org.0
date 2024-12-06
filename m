Return-Path: <linux-edac+bounces-2652-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FC9E635F
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 02:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED828117F
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5013AD2A;
	Fri,  6 Dec 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ausc0bxd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBB2F855;
	Fri,  6 Dec 2024 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448386; cv=fail; b=FN1/tXMO4px3QvI++7Bncldp6zr709Td3+jDZJZxp57z07g7tmauG4/vv7QwzDbwt326KuSRMY6R680w1/1dINjWgw3QMQC1OAYQHYWjWSn4RmYkwXU0A9Zf9TSRIZntlPjxJZJnI9/bt8jSUZxxnLDTlHp9R7lqpo0OJgGCsms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448386; c=relaxed/simple;
	bh=MLN65wnjST+tZVzUyVK7KPGv8s9egO1AJugebP9S2m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WM8fpRCIUYKZZTgJNnzC8CPWUazOBkGwF7Ha3aFLf20A6xc1J7Ol+DFeu8LkD2ItunwXdCeNKnmRjMb4anFv0ss3kxzgyS/EzM8K75y86je3YCkQAL8cEZ82PwpkZj1Vc+QTx7SoOlh9ggRUTdwPKJRlLdARKOnkLaxxfnYVWJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ausc0bxd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733448385; x=1764984385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MLN65wnjST+tZVzUyVK7KPGv8s9egO1AJugebP9S2m0=;
  b=ausc0bxdaftBe6LnoQgvK0pNtbd7joNgBjvqWj9ZJirukg0Ee2/7x45U
   aOmDURhJ+LIsGbYGSL8bD5065EVz8b6ZlbYckn2R6mZZ63JCYkFq5pvtB
   xh9RAz+Gg9vUJZeIuY7+TP2WaTL/Kq/Qbdf2dadk5jMTQGTDgwoWYNsUr
   r215QUC+c0yMkIlSnCXuWMIZJCcArAJuzwva8TUQ0fC3TaDiT/Pb6Mfs+
   lpC3BrcxvTOmPlVVSNNr5vjkPYjtMS7IZlpk4tVAvNpmWd47i5uf7RiHn
   POs15PQjrhSYolo8Hfek3vdYImr0JU8iy1ImjPdUCnrq/TursACq5IHMz
   A==;
X-CSE-ConnectionGUID: ok0SerxmSEukWvVWwXokKg==
X-CSE-MsgGUID: B6hkZgssTmyFTCYOUaGO9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45182431"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="45182431"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:26:21 -0800
X-CSE-ConnectionGUID: t2+cekviT3a+xZxK3G9hgQ==
X-CSE-MsgGUID: a+Em6+8fQp+/ZndrmpfuUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="131678933"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 17:26:20 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 17:26:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 17:26:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 17:26:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDnPkcUI6vaxJfu1JKuaBSOlL80NcpTMXSCtsfEnc8hkFQLdNXriIqnWGeHpLaXU+Vy5EWv/PJhmfoujBnJbxW2QlYjCCeWjHhIaDJASSWBbkDepmKycUofifEhHS1QG5U97I3GuIIHTuWyyXzNpmtfkM/CYgK3jEBLcpfmbZ6Lv4UsulQh7oHRQlUxfw8ccPR+w+LF8iusqxlxxgDQYfTc5tyfd4WtzEm2Kgydv5e4ZrHoGU5KOC7OpRhOL9xbJjNGawxuYeF8VOH9IJPUU/LN+3ksDrth7a9+uwXn3PH+QbIPeBBa+bkr27tEdJZBh9xeSneMxnQYDm3IMV/wV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNSZWf7zQuMzPcr/rHPOGz8n4hdRgArcFV19O9GbHG0=;
 b=gDHAnuu8QsqHK/Sc8qPTtvH+Xd7OBzpSbhGfuhNvW8hdPxZf2er7GD2lH3MxxpBty+zt7DoxstyC8n2agPlCZ/R1Pvz3TQ6r7M5E6d6WcVc7iCyg2827o+333kseZD6in23L+lUU+BPC85NuJiYfGEQ39BvhPzjwYw7dzVO89dqPQ/1DMTDY07+o1EtVkaIimsyRhJ/X+ClMFMMiFl/zgrV9LHGbvLiMbT3VM9ZLLjHLaQhfIIgxk0MC5GBqHKy21y2MafpakKY8QGYS+dh1e51xzI/JK2Zbjkai7sdFjOBr4VWHf7qiNrqs+eDOsIhp1SapykzuBDwk1ydsIah7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 01:26:13 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 01:26:12 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Meyer, Kyle" <kyle.meyer@hpe.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Topic: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Index: AQHbRzsiTcAXApF83kytsud1hydtPLLYBQuAgAAOlwCAAC6BgIAAEmeAgAAQloCAAAcCEA==
Date: Fri, 6 Dec 2024 01:26:12 +0000
Message-ID: <CY8PR11MB7134E24098C6E16E43C57EAA89312@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3> <Z1IHkBlm_0p-0-c3@hpe.com>
 <Z1Iuk-_VdmZibOes@agluck-desk3> <Z1I-A0Rhc8AHhvtw@agluck-desk3>
 <Z1JL7fevweCQtTnT@hpe.com>
In-Reply-To: <Z1JL7fevweCQtTnT@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB4672:EE_
x-ms-office365-filtering-correlation-id: d5bcfc85-e88a-408b-61e6-08dd1594f87f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/5Zkwb2j3i8vaW5AkaNXhwFjZ34DuHZ7Cq9rUOMJlvwBj6zc8idV+QyN3hJK?=
 =?us-ascii?Q?Hh+YYqh2bQnd6o/O/GZxfAdKUBgbkAXp6UdjmjOaIeMnFHXSGX0jCUQOOn1m?=
 =?us-ascii?Q?nBZ9RxJhoM5o3mfexu73dqsgDSYP2PrEbjF3sROALz1d+Kj01ZR9mYIxgg8E?=
 =?us-ascii?Q?2z0sHCCUZFHa7fR+J/9t0woYz3UiosKvhxiN6cEHtdDXMcRFDDUQD5RqeQ35?=
 =?us-ascii?Q?tJqtQxt0GYDgm2hkXczNF7hx+CuWnb2W670CQJ0oe1w3P4ZFO/C3B7HIo8dR?=
 =?us-ascii?Q?lj5W1irtmLIwP4ysjBEmObtM9MSIhBsDSwgBp+iU8ozmqc/H2aFgtw3riaJL?=
 =?us-ascii?Q?pQIYqXaVRDN14KESDe3Ee8E22LF+eWBzMUrb846rHnllB4fpqiYTRqfyFvnO?=
 =?us-ascii?Q?NMaWGud9r4Zn3Dbo/w/uMlDscvbEzjy5kjrOobYD0XA9r8QbZrxu4jbH5Hgm?=
 =?us-ascii?Q?ogs46b/X/9M1c44d7zcX8WdrQrqSaL59wUSR9uu0AIpCO4eZGA3KSTmV6QWN?=
 =?us-ascii?Q?6a+1PkKm1xlyVdKhwdunh+0Ygj6cBYeZ/pY2sOe1f5huu3XqYh/kVJHuhLXl?=
 =?us-ascii?Q?8wSRXNI/dJj+Gp7EERJLahL+5XOz83NlC+uNUBWVPQM7fs54W/XXb12l1rrI?=
 =?us-ascii?Q?K8Kol4i9prUdgFaIkK6IOD1xbGx2G0xBeHid98r2vM/e3lt4kn+lcDXSp37a?=
 =?us-ascii?Q?zTOiqfaqUCOdAONge+PAiTghzG1qYAfr3wvxR1yilqJRovh49g4/px/L3uC4?=
 =?us-ascii?Q?KbvZiUVJkwDSI3j0vWxiMyda3rmA4BQcfcb6/u7OLarey5Et6piVzvbDnQ3D?=
 =?us-ascii?Q?eecdHGKpvCkyg+pTguPC8eIzMdNK/G/OUPfBjuLIL4M5RVJvDA6ILdwEDA4k?=
 =?us-ascii?Q?BJN0PLcF7QjvsmL2NrX1NEIAVYo0onScJpl88UVuGWx1D6wp7cZdAe+JdxHh?=
 =?us-ascii?Q?mUn6r64NVNpbMnew+ny9Oeem8WrTkvLKmn3kXT4zr2szog2xvTunp2vJfWfu?=
 =?us-ascii?Q?w1fJMhxD2kudqpC3qpimGNRqmVBIwLahJk/iDPNSJIiNL4XaeMp0IpXcEsmw?=
 =?us-ascii?Q?x1x0nLMtDjLwApt6f9DUARBuSaFxmw5UQXE+pwo1bl92ZhlW3odAg01iSneg?=
 =?us-ascii?Q?aLL93ak8KEMgae9PPbCZAruDYEporeHRucASws17GiNwAcEZ2mqFZGC6Takp?=
 =?us-ascii?Q?UcT8rdeMzMHiogfozlLSccuNoNqceSk/b5YKMeunmB/XBqhOv8fIDjJJg+0X?=
 =?us-ascii?Q?i3aVzq3sYQnOVitEo/kKVPsocrPkXWj12+lNWKhKZugFFnSdNDdYBGIR2/D9?=
 =?us-ascii?Q?AmaSscAEA6Xzo2RDnLmT6vXl0469f3MEByJT/wC6vBgo7TyTcSiobMirOKcZ?=
 =?us-ascii?Q?jmGutmVOyz1wy5fvwYJq2RgbqhMSsmBytBefLVpZbhHAoTq9zg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NLgRFxFAqi+Eop+QXX2jjZioVQ5mQ27zqDMxvwUQbPtG1wdATJIi4nuIUulk?=
 =?us-ascii?Q?zWdVusrHlZ+nM23C2rcBY2xWjnHr4G0O1PiDudA1IjUKrhNMEMmAukr+En0B?=
 =?us-ascii?Q?dMXsxgkgU/6jCQJ1gl+zsd0q6oPm7Vs4dqah6E1YNedLpTPnRPNm791pNP5/?=
 =?us-ascii?Q?giRlOadl2U5LxGHUszx/TM0hhZ8Ya82jPJns6O7+PyyhkZR/Rzqb2e4B/X1Y?=
 =?us-ascii?Q?j3dttgOMtI1JB7yiH7ZqxQz+x2o+0gpRJalDtdXNG/Tw8cGWR/0ek176Ovhz?=
 =?us-ascii?Q?hYrlO/QdIfvPonKO/s6Zxj5Aa7mpyJ4Tx/P5XDjZ74geu9HZ+xO+EzBrSHey?=
 =?us-ascii?Q?zN+C6n8sz/dBZ4I5wAJjEAbsuEx1G6VFiOnQnfEPS3DD+DrDVBgB1kwz/pjg?=
 =?us-ascii?Q?sHORYIysRXp/N+Sw8obYMmDM52s0HiN5nHXBgeUnTVVpPhmAXWoGKN3GdGTP?=
 =?us-ascii?Q?KA0tL4F01Gm5zMNPIQ8wGm6SwX9xu58M4V4ZszHBJHvjrByl8nrp5hacMzIj?=
 =?us-ascii?Q?5itczKV/vnj2rcFk+WAWrJhK711U2KziBy/4CSey59f9IFQwe+xoLrSo7992?=
 =?us-ascii?Q?iArB6oD+If7Eo/2GRZGTAVg0tQswGs3D6enTribqNEs47g9G4FHc9wny36OR?=
 =?us-ascii?Q?G6F1+l0Y0f+7kinCnPYen7urYfualBMegTLNm65e9pwBRks4Tdo22F4exy1u?=
 =?us-ascii?Q?nlnzW/nN3OqS97eDR5MRCAJHXCh/VXcxuyHjcHaXxW3mo8sMk9gmxcjyUbfB?=
 =?us-ascii?Q?eQq5vLqifTJVhJ12E0G9Blf/WN3lxhYiADKdYLEnPDoyL1MATc0Qw7mpT4i6?=
 =?us-ascii?Q?i7EeDiYTYeCGA80FiZGJjA+eFywyZe0AHbRvDPkr+HD0LYGYQA/PA8AtPmT6?=
 =?us-ascii?Q?/V1mRoxJkTd5AkXAe8QwJwsYS72ammkhtqQ3dpCUmlD1uxLAB7SVgAnjldWf?=
 =?us-ascii?Q?Iimz13pYX62xlNEfyxGaEPm2NN3x5R68vza/C4wZyvVh5LOdUGPzXCZZfY7U?=
 =?us-ascii?Q?FajIg4bNtQMxARQS43dqd78TaKoq1V8iqpN5NgauXA9y6Pu4WF0VYb4Uwpcq?=
 =?us-ascii?Q?sThJnjPAai8RUil5cRdCSlgaZaw2jjijwO76JPlUAEsw+XNKz8+zF9D82BAG?=
 =?us-ascii?Q?i07hJWBDL1FlpcradlIKjP93YJEZtVKOK9ruzQYivO5Qu3Y1WDoAYnYyCDbX?=
 =?us-ascii?Q?llg25S+gWoFNEE5lMdE6T/UjAunQvp60hMwzhQmTayKTRugnA4kG7Ju2K0U7?=
 =?us-ascii?Q?W7DOKJ2rF9w+gvQf3Ng8hRpFHsDz+g9FPjsooPbM3OmYZYIXxgbCjhQI4LtD?=
 =?us-ascii?Q?AZzfZrgXClnPkLsQezp2OgFc/wRdV7//FTUTnr/z394P/Y2mwhdQcb0HJqun?=
 =?us-ascii?Q?+Lolkn91J1E0CHrenPCImOYArXtvIfHuS33q9rBOS8JVxIucH1fx7Dc6xkFr?=
 =?us-ascii?Q?g9jjmTovb7w8KCt8NiH1oN3X00JW4D/KnpP1SYgKiyhuqi/fL41aArPnHuJA?=
 =?us-ascii?Q?ndOeXNbtrCWTei15R0g9OgymyeVFx3/mFfqYQPV2Q8e69vPY135OMMcZj1s5?=
 =?us-ascii?Q?lXCx7X1QwBxGXzBbe0XLuNpMG6bfBRnRFQGyO2mj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bcfc85-e88a-408b-61e6-08dd1594f87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:26:12.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE0LkFvI4xY9294ygnGuy6ztyrqzcqhLsgBoO62KTqfj/cvKepxwTn4XepqErG829VvUcqoFcITy2jlIkVxmBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com

> From: Kyle Meyer <kyle.meyer@hpe.com>
> Sent: Friday, December 6, 2024 8:57 AM
> To: Luck, Tony <tony.luck@intel.com>
> Cc: bp@alien8.de; james.morse@arm.com; mchehab@kernel.org;
> rric@kernel.org; linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple
> clumps
>=20
> On Thu, Dec 05, 2024 at 03:57:55PM -0800, Luck, Tony wrote:
> > > +int skx_get_src_id(struct skx_dev *d, int off, u8 *id) { #ifdef
> > > +CONFIG_NUMA
> > > +	return skx_get_pkg_id(d, id);
> > > +#else
> > > +	u32 reg;
> > > +
> > > +	if (pci_read_config_dword(d->util_all, off, &reg)) {
> > > +		skx_printk(KERN_ERR, "Failed to read src id\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	*id =3D GET_BITFIELD(reg, 12, 14);
> > > +	return 0;
> > > +#endif
> >
> > Doh ... I alwasy forget about IS_ENABLED(). This can be written:
> >
> >
> > int skx_get_src_id(struct skx_dev *d, int off, u8 *id) {
> > 	u32 reg;
> >
> > 	if (IS_ENABLED(CONFIG_NUMA))
> > 		return skx_get_pkg_id(d, id);
> >
> > 	if (pci_read_config_dword(d->util_all, off, &reg)) {
> > 		skx_printk(KERN_ERR, "Failed to read src id\n");
> > 		return -ENODEV;
> > 	}
> >
> > 	*id =3D GET_BITFIELD(reg, 12, 14);
> > 	return 0;
> > }
>=20
> Looks good.
>=20
> > 1) Does this work? I tried on a non-clumpy system that is NUMA.
>=20
> Yes, I just tested this on a Sapphire Rapids system with multiple UPI dom=
ains.
>=20
> > 2) Is it better (assuming #fidef factored off into a .h file)?
>=20
> IMO, yes, but there's one subtle difference. EDAC will not load on system=
s that
> have a single UPI domain when CONFIG_NUMA is enabled but numa=3Doff,
> because
> pcibus_to_node() in skx_get_pkg_id() will return NUMA_NO_NODE (-1). Is
> that a case that we need to worry about?

I think we need to make the EDAC load/work even in this case.=20
Regardless of CONFIG_NUMA or whether numa=3Doff is set or not, could we do =
it like this:

int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
{
        u32 reg;

        if (!skx_get_pkg_id(d, id))
                return 0;

        if (pci_read_config_dword(d->util_all, off, &reg)) {
                skx_printk(KERN_ERR, "Failed to read src id\n");
                return -ENODEV;
        }

        *id =3D GET_BITFIELD(reg, 12, 14);
        return 0;
}

-Qiuxu

