Return-Path: <linux-edac+bounces-2119-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFED9A1B60
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 09:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD052871A4
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD81C1ADA;
	Thu, 17 Oct 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFkfVQ+8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98583155A24;
	Thu, 17 Oct 2024 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149004; cv=fail; b=JPFmOIaovlUpDeK+IClq0clzsIHO1aMbE/q68nyedRSQ4aHSVVPHnNlS/ZfkA5mLlytRQBzl4Lg/LWpK1fDxCkIgjNbKFCA/A+JI9psYRCeftIDhMkFDTaQJ/1duvE5WEzyCL4fG1IAK/VqFSm5EqbfF10pZaRsA0QL/aCFefKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149004; c=relaxed/simple;
	bh=83iPzY82t1xGrRnKn7WKTeciO96iMoK8QuhahtUvZKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJvoKp9ZNmC5K0dfyZa6T4A48yYeAaB9QJfehpylD/zk1edQYbnMu2Mlx0oZU7IirmvFfMwHBUP1xzQUd21WrOfIiA64wW6j606WI3LSAAK3HiHqexZjSx+mslFmfcTVQ+Cjqn9+/HzTKs48AD2s1E0cuvaBFYmvuvqtrMxgirU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFkfVQ+8; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729149002; x=1760685002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=83iPzY82t1xGrRnKn7WKTeciO96iMoK8QuhahtUvZKk=;
  b=WFkfVQ+8T1t9anME4z5tCMyZ1rPGdOPJmb04lPyFW6wjGYD+Bk1Xs+iC
   eGnBZy40GokZ3slrFx64If07I0YWI5R+UaUWV2svDhURRkzliz0QZasA4
   M01hV0ib9qEQCggcPeGDcEcciGwvIUReC3/lzeaKgug3K/1tXx47NJX+5
   bArtGjNOkz1gbparfwzCJLTj8sY6RZEJic+CT7r9A6uJ8AB1WgZghmsbc
   Lbk5a/OuCi23nDpi6kq5+QOHI+WPObcAUQ1wM63cos09knp8Lr8fQrRkq
   53U/8GJWwG4HLIpn+H0GMnYKql80GqPKp93b7qodfTqQNlhkWk+v9GJ5p
   Q==;
X-CSE-ConnectionGUID: sZcLjq9wS4OTCcbQnXqXow==
X-CSE-MsgGUID: 2kJqAGDoSSGJ+e4hg1eeOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="32550306"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="32550306"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:10:01 -0700
X-CSE-ConnectionGUID: nk2skwJqQV+vfe5YLk/2fA==
X-CSE-MsgGUID: Rw0SoNWgRLOKqMiIdUiDcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83110026"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 00:10:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 00:10:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 00:10:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 00:10:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 00:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amYyyg0UuXEN4g4xfbsMSqi35EuWETi55LnX2SLEIvKxQNqlksZjq4gBT8mpacPcSR5F+6f3FvXLUIEHMMXa2l0rPax1ErUalQ0HjYKeaS8j+2hmO6s+ZmKWYoFsE2HB7KdDxC/FWjYI+9QGXdWqRBeZXZXDZB5x7ppNwRiFsJ3UBJ9QJXkhW0zMrAHyUx/WebMppi72NG/MswrTiQB1/GKPNdT59AemWK2J3rkzr9sIUJMJUm3fAOmLLyKp6CuW4biKufc4UJWrLTPkJxnaE+0mQq3NCZy174IL31dAu18rtwehheIFpiYPznpzyQN8axbucYTSoh5VQrVCO/tVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7bzGNLwhbiMIGk4hwDoCDEywqkW1Io6kbpFAHbzXwM=;
 b=YwObQcBt+cUy90R3ck5iy6WX1a/P/QbhvTVwY1cup6no4eBgX6SEBzdpVbQo2YrxDh+Od699hqWpozoS1vQuX7BiFnu5LwSpab8kyXBvCpsn3NWx8lXjepKoBsIzhUWta/7bfxLoRtb8LfU/jucQkhHemQ+szO2maahVVuZ1k/DfOzfDKjpkP/BmSEhFAfYvAEs0UVHQuA+XTfuIN/BMTr430o3cV2pHfX0spqKTQNvI4vGCvUfnVm9VbrlfIOM/jHAKrQS1Dn9C3A5iGwj+mfFe+cgEl9PUPlh6xJgu5mZq3H0pSAoJ9I+e9b0ZJSvVr+rcyEQDxZgexDfmXocOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 07:09:56 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:09:56 +0000
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
Subject: RE: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHbH5ZrAuU8UmdKFkOX3yhViLnZqrKKhOjA
Date: Thu, 17 Oct 2024 07:09:56 +0000
Message-ID: <CY8PR11MB7134178B954B4DFFF6AEF81689472@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-4-avadhut.naik@amd.com>
In-Reply-To: <20241016064021.2773618-4-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN0PR11MB6160:EE_
x-ms-office365-filtering-correlation-id: 1d3ed506-5bd0-47d2-a64c-08dcee7ab4d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RclloHBfbz2Rj/laSsJk8IdBzrs8Rl8aKhbuwEWH5XOPTO7YhBTuDtXvo3?=
 =?iso-8859-1?Q?zCbK2cekQq9waK9szZ/f5UWaX3AeHitz377cVNlf/jEbxZb+MfSo4RHgyV?=
 =?iso-8859-1?Q?javkLqzHAPShK66igFt3qBpOXmCb/x0d6lFW74bmW6hIsZs/BDgYaFfxYa?=
 =?iso-8859-1?Q?hsTzk6pDbwAMdG4HlgtKMRF1o3qyqzfILqi5524OrJtUgP1TWi5siGI3Bd?=
 =?iso-8859-1?Q?xdwY/I+OANhK4EfmbOOtWDte/2E9cbMKm5nBx9NoLdBi51Ta4GzqJaV0lS?=
 =?iso-8859-1?Q?6ezLjW+5+V6zYULkYFh/bVs7h3YilU20G4fsSFWLHdiTMA8tvuJWp698XN?=
 =?iso-8859-1?Q?VyQp+/P4xGOs4yuk8yEFTYgEbnI1R15Z504NCE52RCs1hg57ieOvjhYPP/?=
 =?iso-8859-1?Q?fNQBvP0SXlOZKbeI+AoZQH1Abdjcrl+6k6xJg9KeJw2yT9XHKq2//l++zr?=
 =?iso-8859-1?Q?3zQTY7JO5zyXnWAaDMCNgTOS2d5cdRDB01WcXXfCpJEd+MksiuNmI4XyQJ?=
 =?iso-8859-1?Q?mrLDPbMmy4A6S4XYdxt8ZDNZfWTxQixbgXiPSyzYUjqGLIGiVhBB1q+qMo?=
 =?iso-8859-1?Q?USrsozIcieDzjVaSSvc4vMhRfco0N+5sbkmYl9gabVHW2PQKXR2o9SS8+x?=
 =?iso-8859-1?Q?vwK2xCrEhhvHAYUivPzxqBL/tW0sVEo+asShwG2YlIygghIRSh8fRaCUOO?=
 =?iso-8859-1?Q?re3rPXlaEAibUS/FYe9lHwApM3QVnjJ65OXz2ely1o8Tj87Bw9qwufyqso?=
 =?iso-8859-1?Q?Fv/zrewlqgV8rHYsp4Fnl6ydfnPvrdWbyeDg377oUUPTODq9R7gPQobvpN?=
 =?iso-8859-1?Q?0tJDrJwrRFsQE8R+TUdt5n4vLtwQDoTOLg7ZfjMpSYK97SmiM7xIF23U+2?=
 =?iso-8859-1?Q?iWgDgDxEtYwoT1YAly3mNQ5ZJBEH9S0lqqE50sg960NL83mmzD1bPwPGan?=
 =?iso-8859-1?Q?V69igj014sCiipl41p5U6qeH7EVnrhJ0LS9ZxsTnNaTL0xOThViQuz8rC0?=
 =?iso-8859-1?Q?0aeI0mlbPMsOMswzFohiwbXH4oDAYXWIm7IAU8qjEKIa7g9XlHGLNhMGyv?=
 =?iso-8859-1?Q?KNVe7VLJNJsEk3aUudgDWlJlqnf1JPtrzeIyM5+VmMixiErGxH8G4BGF48?=
 =?iso-8859-1?Q?9aEOrCIkLT7XvulS8y9PPpDKEsy3Mz5jjhYS/Lanq6a1oM5UQ2oDiFQvba?=
 =?iso-8859-1?Q?Upwmw5OW9wFZP4Zv+3myHk37EKHKHoI6X7GARMykkuH89uWF9r/DC53r+u?=
 =?iso-8859-1?Q?+2Yk3i2FWWXHSUnmFqQsY+4RVf0x5Gchl6RgRXoXvBYBhpCovMPgl9WZj9?=
 =?iso-8859-1?Q?Umrm0BfcAN2gFcCe7tr4NaLUCEsuRR/SRSNru5SHEBhBiALQm43FrszHrV?=
 =?iso-8859-1?Q?Yyc9hsyUD/swWK87CSe8Mjgo4XOQ6cLQQOJGIff9DHd4jlZ5POl6w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gHzB2oZNW2todiA1XZ8XiOgNcYCRlOSf0cmSFZTgomZak/BRptzug4b0da?=
 =?iso-8859-1?Q?ctVS460KsEufbYFZVrK/5KYHB56/dQ+b4yrM4n3jbqKOHZwQrFvpUapQ5h?=
 =?iso-8859-1?Q?/eQ4CHV3FSxLPcquCUL1OtEe4+I4AZpMnUc+OPiFpP4+ceeO4JPzMJfOBJ?=
 =?iso-8859-1?Q?SPWczSgq8JwvD0rb5IC8W3rzVG/WecLexk7ol8kE0FHBDhb8bkvdt3h7YB?=
 =?iso-8859-1?Q?BsDfHTluDClbYlc/ZuW8Z9vjd4665A/7RBsQm6zHCHMNSiizs9Olv2zZ16?=
 =?iso-8859-1?Q?eUIYL7O77A2K1Jx6vC46vIWpMJFtPpy6rf2xPx1oD/fC6FWN8Yncsr/Sfa?=
 =?iso-8859-1?Q?K+hQSKuDdFjT+VpgcUp8PmCDKI42SD1vsrhrd0ACsx/O2IkjXC2g/Pe9x6?=
 =?iso-8859-1?Q?DVmHM+sz1o48W5dhukufmvJXL3I3JKhMWDlEnPLxBrqg87yyD7PW9NP80w?=
 =?iso-8859-1?Q?ISSrryaXDDQwm92eVQ0Vw/4GUpDV5cSrVVhtuMifdnKVTOScrTKqJ4bXMN?=
 =?iso-8859-1?Q?SqX+crtzxZ/f8/xOg89nqseaaUUHSROsNanNCZyunIQfqYd9gC0XQ/KzKD?=
 =?iso-8859-1?Q?u2n0cMwdGzfnS7dEZCxhsehUn1kIGyrJ5u/YnRZsO1ieORR7upQM2YdNOi?=
 =?iso-8859-1?Q?hLMOIKuLyHInaoBJnIIcsh/8dFdEirF4X3pR3oU2a1eCQFQoWJ9ocHzUCz?=
 =?iso-8859-1?Q?NhreqqwA33juiIPGpdn9zBJb3grgqZlyJqfdHgGyLQ31hWrbc6tDo7jqG7?=
 =?iso-8859-1?Q?NrUX5OX4ZHX4JkEXqc+lHzwO5cGjj8S7tYw3Ss4aOJflQABwZtQQp2dkmH?=
 =?iso-8859-1?Q?ejYdlyVT3aTYdDOl2TBcGpXSSoiamPdMaWMGPCkJ1xHduB3NJAFiIShjlX?=
 =?iso-8859-1?Q?ns/jO/fuICk25DIzJ9lcZZ1JQLhcKVdTVAU5RZUBDExpz1ikLd7EmGoqJ+?=
 =?iso-8859-1?Q?axZfy5EEphDrAjcu4XKVp+bZXDeQQdbTQu27+1gxFAKZjVr/JzygsnGUkA?=
 =?iso-8859-1?Q?g+DGEcw/rdaT+NaTowcNupLMro3B6gtTP3AGrpEJORZr1hTNcDSifylx+N?=
 =?iso-8859-1?Q?dMKZs+yMlIh5vR7AqupVOjklPy7gy38gOl5y7Vph29Keo7v6gh4fcIMky8?=
 =?iso-8859-1?Q?OH08qimMAcAsymU7PGOGOjPA/XZ5p31jC1DpLCgU4VmQlNXY5p7zMYXzhv?=
 =?iso-8859-1?Q?/k5sC2nMTEzLdzkn28CnEB5QWfP+H0cCf9CWhOOEHaCqKptOulcJF1qBzR?=
 =?iso-8859-1?Q?96DhG6iaZUsujRFfRiakxN7Z0DTOM0kZCPiKP07ylBX9G8wwX/WpDlHt1t?=
 =?iso-8859-1?Q?WG5JbHN5h+lnIbNplWfRW90tquYt/p1EqHiPJ0JIsRHJ9fZWOxgOHBmjMX?=
 =?iso-8859-1?Q?FJUWepogCu5lZL++DVltu+aYiBHDXsGtg72zKjiSVc98wIqo8hzd5ebGCI?=
 =?iso-8859-1?Q?+tUgBv5X/FVZ/u2rmSPeq0D1TLAVtW43rnI18bM9bIyqnwU6uFWwJztfjo?=
 =?iso-8859-1?Q?PuLK1PYOKgLT6Kure1Qssu+3MBEKSjImwnYlVxNmth0i7J/R1nUmZYOg9a?=
 =?iso-8859-1?Q?qdIyKiY9RAvjtdEr/OOe61YrRapkubrPLfcMm/Sc298h0eVrksIZv3xU7o?=
 =?iso-8859-1?Q?7idqv8Sk5BD+Nl/dmKFJ1BErqdNeAf37cJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3ed506-5bd0-47d2-a64c-08dcee7ab4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:09:56.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCArVpRnxlBlPAm7hfO07iH/EpMjVJHTPFYtnQ8SKIpF122FRKpGOIHBfMoVPl6i94Y2K943GvrsyuslXw37Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -43,6 +43,7 @@ TRACE_EVENT(mce_record,
>  		__field(	u8,		bank		)
>  		__field(	u8,		cpuvendor	)
>  		__field(	u32,		microcode	)
> +		__dynamic_array(u8, v_data, sizeof(err->vendor))
>  	),
>=20
>  	TP_fast_assign(
> @@ -65,9 +66,10 @@ TRACE_EVENT(mce_record,
>  		__entry->bank		=3D err->m.bank;
>  		__entry->cpuvendor	=3D err->m.cpuvendor;
>  		__entry->microcode	=3D err->m.microcode;
> +		memcpy(__get_dynamic_array(v_data), &err->vendor,
> +sizeof(err->vendor));
>  	),
>=20
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx,
> ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx,
> PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x,
> microcode: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx,
> +ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC:
> +%llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC:
> +%x, microcode: %x, vendor data: %s",
>  		__entry->cpu,
>  		__entry->mcgcap, __entry->mcgstatus,
>  		__entry->bank, __entry->status,
> @@ -83,7 +85,8 @@ TRACE_EVENT(mce_record,
>  		__entry->walltime,
>  		__entry->socketid,
>  		__entry->apicid,
> -		__entry->microcode)
> +		__entry->microcode,
> +		__print_dynamic_array(v_data, 8))

What is the 2nd parameter '8'=A0about?=20

The 2nd parameter is about the element size.=20
The element type is 'u8', as defined above.=20
Therefore:

    __print_dynamic_array(v_data, sizeof(u8)))
   =20
-Qiuxu

[...]

