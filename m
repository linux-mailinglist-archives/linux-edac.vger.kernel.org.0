Return-Path: <linux-edac+bounces-2228-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A553D9ADBA9
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349BF1F20F35
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62ED172BDF;
	Thu, 24 Oct 2024 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoCuA2UO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E41714CA;
	Thu, 24 Oct 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749005; cv=fail; b=otPS6WxsWYbAPS0M8x0I8hwI+6uU9yhouwXIZnuF/evRfiMXZPy/OLDKjc8ekv8h6Kry2EUbOylKBX4IleuMPRfAVNMHV2FTynAUgAN9kBPSyGBKB0hEDPOtypnJqSu8C6euiDXOpHDXaxD2DnuI0iKun9ecUFW6JdfiGVHFZD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749005; c=relaxed/simple;
	bh=F06vtAE8e+biRwF9Y4EYzEJTd8tkyUUySzG4H2hv48w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSSF/UxzpdpcZi3c5ROEMusKblGuvy/8q3om6ZkGlc+zvZZjd7DNGwKDiwYPaCJBGuctR+t1zhqi5+RLDxKeBsHm5ufLQgVOJ5kpuu98U4onQdMvqF3yco3ivPVeDgpPr+yTI/Jy07OXCWTqR3Zb6+dkertx5z5vThmgccfmOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoCuA2UO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729749004; x=1761285004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F06vtAE8e+biRwF9Y4EYzEJTd8tkyUUySzG4H2hv48w=;
  b=SoCuA2UOzoB8P3jA+VvmRD48YPSRpf6u7X7aCV/qd1iTqc0CsiSF+abe
   Rcp3Nclm1yR4AUCUpxGEYVKq5SU9rm/S7Zns7o29QBg8cAwvfM9KtGR70
   uEgSXduOCcY3lzmlIjn/YeyQ9+XulPq9du9VZixizWnoZdCwgMQxItZ8t
   RtgqSZrcgJFm+/seqTIwQjaqTPX7AdVIyI3dO+yYUAinOAhilSkU6bUaI
   kguxd7jJ31Im7mhCdvtMKtcDNnKNGiU8G7YS641Mg8CCGcolOzJo8BEAz
   BPneoq5oZ72jYPCzutGnwMdAeU0yMpip5Iop4N5q0SQ9jRwXSITebc/NX
   Q==;
X-CSE-ConnectionGUID: 0cJFKGR5RDGATlWrDH7ymg==
X-CSE-MsgGUID: R+kodfGNTlixJCGiTrnO8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54767680"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="54767680"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 22:50:03 -0700
X-CSE-ConnectionGUID: oBcUzxCoT6+5Slu7lGwoww==
X-CSE-MsgGUID: 6uishX+YTmaAzCbq1b7tjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="103809809"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 22:50:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 22:50:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 22:50:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 22:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFq2giBfoLPCpaIpfSADe6CaO/NGnpNyTocOdIq6KKYrMI8W4MiyT+rtIVFw4Lc5FCnwjlLvV/2K8ixJ5qfmKspDfYaq5WgMCpldGgECvIpk1O01AF2p9CKlMeXwrLy+TIP7AJB5bFYuV3kTbP15fpikAJl7OSf/Fh+gIh+lAxbUvYfHsPEQQZ2LD403gT8VASInZwEUlzffxpdJQYssw+8hTqeG9DS3/lk7gMWAv1iRPWHe/YDnoJSyzYm6RrKkTIk8PzoM6hgx5ih/jIkNrd3nIJKcS50MuDKXfddNQuDSH2x6Z/wyf7ljgMKWUdzmGPVtz5kKiKFmwnyJzaJQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2xYStNsD34c0wY7gzPyNWr8zyCSwjWgqtNhebt+yYs=;
 b=AV75hX5MBPb2qEOKhSxH2ClBtOPRIW41Dd7Nrr2LFgfkpvK/Ls+gIkp/PpA6OjdXAjpeTDJ1lHqz2UAR617sGmmFxKW7kyQ2bxXmpICJiad2Sy7W8fHH8SLdRyG++lKqtqL0vm4mGq5R+YxaubI8vbRX2rlpYIg3fYKHLFsUCbZcBAEG6Tjddj2WbRXVqQdVBeuIahrA3Z7+77rTOy5OgLduXmTN1v4nPFHTOcGIrQ7NhROrvbZK14mxYVkwThl2t8Bi6DMP7pvBw5fCh3Y2dbHZtD/4ra2rh0uMjX1Hcjm3W/3ouontz99Xj7pqVeqeIm4w3Kx7phMjabh1B/3/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 05:49:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 05:49:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Thread-Topic: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Thread-Index: AQHbJLqqoSEHCnqnXkmP9yN1EoZKBbKVZ3eA
Date: Thu, 24 Oct 2024 05:49:58 +0000
Message-ID: <CY8PR11MB71343897FBA9B277ED5454E8894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
In-Reply-To: <20241022194158.110073-6-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: 6b9dd589-ebb0-4292-7cc8-08dcf3efb20c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5Uky7AV3Zw3AGXVzJ928dHE4dM+xI4J3kS3dhygr2Jb0hz5zAuVeTiKfu0fi?=
 =?us-ascii?Q?RFWVgjbWZ5K5o0i3Kp4nCH2wtDsgYd4eAkMApXctOqjvk7HZWFzF0VThRvdH?=
 =?us-ascii?Q?xAF2WwBh4GLljHlUa4sSYKPBp0cdiWEAQiOb9NdutFOxYCI9cxMaTTLiV//o?=
 =?us-ascii?Q?CaGX3tiJRPuiPfYLeuOUa0K33hADe54JXJAyfeSIC3t//6TI4vPd8CfrXpaR?=
 =?us-ascii?Q?GztGthqFgx5fmJ3w/oijmtFvKevlt7Jj0syjcVaNG1Dsaoqa6a/1mc1yNzsQ?=
 =?us-ascii?Q?TL1cS09ogilFpMA65h64US4j9v5FjutMDGFUSV7pkMCQfwsuQx/AhXYhXJV8?=
 =?us-ascii?Q?4+8xGDypFNzYfQT+X/d7sKMhDzZa8BwCnYvRQFoHjn+6Or+yOjNja6MpPxk3?=
 =?us-ascii?Q?6+o9ph62RURfcyME/tRdhSiKugZ5V9ffrcYWnbx+TuN5JU8KW5cTvrEyEsJs?=
 =?us-ascii?Q?BQ4LXTurB1R8ixjA5TWlRo6z4gPJ66j3YNb/qf3GRrhPlhHKN8bOHp64EqIr?=
 =?us-ascii?Q?8uyNWtNIAljoYAIPYsPYJQG2zeOduRlB60NdAhnAItzUx3D421CegRvKFAis?=
 =?us-ascii?Q?zGZAaphr6kTev/763hhGAY7EzNOVUs96Bjg/d2Q7VNweERLlkMbyuwc3Brk7?=
 =?us-ascii?Q?/fScpsWHrDOXEEQb8/fye710enPC/UwfAgd6L886aGsjOcYPVFwhh6TKLtli?=
 =?us-ascii?Q?XUuSmOvkbjI58YOALEwHfHxeQYXDoZf9xQw+l18s6B4MNv7ZQ+A1k7kuQmK+?=
 =?us-ascii?Q?MYEIWVSZ6S1MLgFnU8xzkfh/0djw8H5ho471BHwkxn1hDs6Jsy8CQVzEN84l?=
 =?us-ascii?Q?T+w/xSRDGfvrA7D1wEgrL0VGONTuAeW37Ftd8JdsLT2m1j3ZmLoYYB6nR8Sj?=
 =?us-ascii?Q?NZFjesfAAbN5Qm913yXeU5v8VZz9ul9zf/hUJ9mkRBQBmAKO0J5HADjCHDXt?=
 =?us-ascii?Q?XVuSzUWkCVWRbRbZgBx36H3GIURjdiuCoHnLDbdonBFFve3UljHdJEodd5uC?=
 =?us-ascii?Q?XJeQxD/wdcNOomGwor1gvzfkYFYlt0IyoTP6Q7YcYaooFq/3ESvLardthdrW?=
 =?us-ascii?Q?Z4lRupEjIZpTu1sRJuema5JB6NQ5d7sO7Po5mTTFRbfME68Ys7KFp/zs/Fnz?=
 =?us-ascii?Q?YKBKmOCs90zat3B/CnHc78BgH+RQG2001GrkcCQ5f+lqdu1UVU+k4mJZ6nRf?=
 =?us-ascii?Q?W4Pr7RpKFAqkKWxQ1nx0gsEl3LssH2geNrSR5GB/zmVjX49r7kxDPgVzEHNh?=
 =?us-ascii?Q?3gtsiZPuJk0JeyhdWJbwN93aQO/MDAqH/GDsIasLbR6umezWLup1i9PT4Sxz?=
 =?us-ascii?Q?xf+4nhjU+KOork9ZYFMAfAtWez91J9vsh2yR6gC5BVfw+YAXOf3dTbNlK8U2?=
 =?us-ascii?Q?glvl3S0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XHql3/qQbUsnNNZEJyLKLa86vRjWQF/XRDL5HEHmRWzaWtiptb0PXbnzUizc?=
 =?us-ascii?Q?JbM0875owjtUkC2f5pZIQLNuI/BNVepBqzfc0oq8XoYZyOHtk/eF8kpsZf6b?=
 =?us-ascii?Q?uRNfZX8mM1lNM2SY/OTlhlVzxvPnVGYgYCo8l6KN9v/0zHFpk1P7PaL9Zx8f?=
 =?us-ascii?Q?2sxsrezM4o+nBXIW6Swqd1ZiHMcX4IGeH7sWC82cSdSETT3VEaVMzmRU/+HN?=
 =?us-ascii?Q?vbVMPeP6xtzk8KonyXlprMntSINe8Re3bY11sURluouBj0dqlAd/TDc/Eagd?=
 =?us-ascii?Q?uF3+gxY0W0eYq6tkwYeEiH2xqlZHvY3hntMcGZzIEGXpV+nGWd6thaNLVvmL?=
 =?us-ascii?Q?xhsH4X8JtOGp8o/NpjZ13LOmmPPAQZf+tX8fUtDw9lgYshpQqdNAVKKJ+Piy?=
 =?us-ascii?Q?plkkBG4jQlPL/izpOXK2Qx50zbxFFgUtMDQNZ7S84DK4rTogdVebNSOH+FmN?=
 =?us-ascii?Q?D/DgVIvtiD4Z1n7eoy4BTvs79cdOrPvrJwh/Vxp74OBvbUGY6zHuJ//TQtlE?=
 =?us-ascii?Q?aDslsJFTMFK5KrSd3JHD/CBDgtsXA/yL2ocgz9U1D+o6KtAXi5pX2OYYpgn6?=
 =?us-ascii?Q?WmcwloPQd4DC21bonR87dJTva/YFt09W8ERoPD3UEt8CxwcQswnAV8leFCq1?=
 =?us-ascii?Q?6HDTxEFkPspBsb579TrcTMOM8w1nnTAtAjoD+pMJh8m57bebwfUSEo3aeQBn?=
 =?us-ascii?Q?NxKjeuiThxOq8qCd7TQBKt5uLxhFdPJVBShss6ZgZTtlUsvbvNdUC0YOYRHo?=
 =?us-ascii?Q?0LlVA/AgQlTsGJRYFI3iX82kk4+YQhI9KYzKQq4zAE1pwtXWk0e/kopFliIg?=
 =?us-ascii?Q?Tr8r08Kr4zXtuIYep7CfhS54gMxS83BwbUMtKe2JeVNHW54S/l+t56qFhVve?=
 =?us-ascii?Q?wQnnO3rXXzipsNYI15BVhLmUhazjgAwpBtxtMdh8R0HSdLqufraRzQnv6Sn1?=
 =?us-ascii?Q?idSHAybt8MPktyva3A1CUbevBIVfvWpdQVmVjC6ndykmWofWFULk+K+m+HkC?=
 =?us-ascii?Q?yRhIq9W8oUi1GDAdUuiitL+S4xqIpJ8mBThemm+bCTfcYKme7ZjcwDDQibwt?=
 =?us-ascii?Q?K6XYOmIqRPY0WsL1qUIEmcqJ0cFELeGum3wZ61ZucbHMIkFClTSydgksuLRO?=
 =?us-ascii?Q?Cegh1cT2nidF2PzgX4AI4jam1K7Ng9peGR5+JERx7+8Rj/EgJhsYHJNnpYTK?=
 =?us-ascii?Q?svXFsirnwpi49Mln3wZo6++mb/ZmLNvrSrrEUmf6i7ifCrk1+Lt72jH7vNwo?=
 =?us-ascii?Q?kLK1t9f0VzuOFIGMhmvMwToymJ530JkveeLV4Mbp8Val4tfJ/GBGx9FtBmxK?=
 =?us-ascii?Q?j6pKxaR09047Ju+S5AQ/5qb17QWeUs1HI+VtpuOcA3uX4wKXGvFL5NbpAw+z?=
 =?us-ascii?Q?9pDMYQtkaNCSmBcY9JbrgHfBnOCik217RrlVKPBKI++4U0AhMUc+momOBU+e?=
 =?us-ascii?Q?oFFobsI1pzG6fqSCPFFo57b+62P1ecEWLHcFLQo+MCeWCjDtFEiZF70hXEVq?=
 =?us-ascii?Q?MG9RVeQOWAuXrrBfCUDtXiEsnnhlUiRw3YeRmTto1mFvJamElYCQDG8De75l?=
 =?us-ascii?Q?DohvmqKLCY7Tm/VwRPMHECms+b2W+Eb2QUr3qaQM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9dd589-ebb0-4292-7cc8-08dcf3efb20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 05:49:58.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTCKhTX+4XqkQB5ZH0WpqnA56CshPqp8nDUpzRYTj4XAYnaUoiNvEE3WIDJ4iLEgGBrhV3PRzYaJ5UFoQL+dHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> Subject: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> A new "FRU Text in MCA" feature is defined where the Field Replaceable Un=
it
> (FRU) Text for a device is represented by a string in the new
> MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
> bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
>=20
> The FRU Text is populated dynamically for each individual error state
> (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
> covers multiple devices, for example, a Unified Memory Controller (UMC)
> bank that manages two DIMMs.
>=20
> Since MCA_CONFIG[9] is instrumental in decoding FRU Text, it has to be
> exported through the mce_record tracepoint so that userspace tools like t=
he
> rasdaemon can determine if FRU Text has been reported through the
> MCA_SYND1 and MCA_SYND2 registers and output it.
>=20
> [Yazen: Add Avadhut as co-developer for wrapper changes.]
>=20
> Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

LGTM.

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>


