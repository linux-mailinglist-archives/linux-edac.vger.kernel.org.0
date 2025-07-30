Return-Path: <linux-edac+bounces-4465-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A22B15A0B
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E7B3B010C
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2C290D9C;
	Wed, 30 Jul 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hymQszOu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10E290BA5;
	Wed, 30 Jul 2025 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862199; cv=fail; b=kPfEEucokrlfDloqE/j2UQPsmAPGiHlXixzQ6jrhpdljUaMgrF6+enesuMDOJB5PzjBoCJVvE0TJmau8nRCqqCugiICchxky5Cvznhk9X5SPyrAXV1j01u7C8kgCmwnox8r9+bdQEipjn+5XidbYX3hPaXBdHLB52LzXjSeC5YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862199; c=relaxed/simple;
	bh=RPf2Te3cm6Vd9eI8PQdR2slNY8pGHO7+YJx29grAFgo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o8NJHxiUHLha/9uoJdEU+NSVp41fWjyVJqgwUjlwNsYtXuUShIThADw23R1vL6T/ffKwMMl7IHE9wXAV/eoaUfysWE6XlV5oJcbW3oAWGJTkwYAasuB8S7jUbav/bKsw/w3NrSkOeHrAgTGmVRFFVhHqd8LAT2+RJjsx+e2Sb5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hymQszOu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753862197; x=1785398197;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RPf2Te3cm6Vd9eI8PQdR2slNY8pGHO7+YJx29grAFgo=;
  b=hymQszOufbtSkCk1Y1rIaURKLKywjhxO1mAmDIkh6nHhEZBTvSkxaQPp
   E4+7BFy4Rs7TtBpxynepgmcP9FJZ2J75fY3m9BXt90F4uc9lr6vklGJml
   i7xcROKjOVBcq/kUihu9ubjEJ1Ap6OBrRX7mJzkUwbKcOJ+j+divQgXqQ
   JQG0j3PsIBbMzXDlkmB/RvnMggNNf+I+4k9xKXozlMka6CCAQpHOuW4TV
   pCqQqSRTrnvUVwy0bPAvlTDNrAcgch+FukcW38EVqP2zunOkQdHLjAQAP
   WFMzAGqBzZb5EbbyBL0wMyiQe2JusxfvI5VqNuuCvu1U2ReSMRIfbHmMN
   g==;
X-CSE-ConnectionGUID: s5Esm7FDQIqWkNBy/k0FLg==
X-CSE-MsgGUID: Dv2qCzGGRsCxQey0knBhOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="81597440"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="81597440"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 00:56:35 -0700
X-CSE-ConnectionGUID: gkNapN8sRKCL5od0JunP/A==
X-CSE-MsgGUID: 7usWoqtFSE6Hu7JAUzv85g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="168332582"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 00:56:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 00:56:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 00:56:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.85) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 00:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdcCan13VC4A2U4ca3xanivZZxFj9ZDHWFTmdWORJ89dBBaLJo0syHtF5l0bZA2wQD4+RPCMQTBp0ZDpG3p5b3rxSoeIt9HQTZXCcQ4H9k1RgdvoLuP+ysYLfQMWu55fQhIzFhNyE6YgJfOz3U53T5Fj7d3NaqY9AQrvkQzUrAmeWD1RSiVAZtmIeVVExv1kQEKP+kmX/ZlraxYdJ6tz6ByxWr/o51b2sYL18aNnWR7GtEKVJ85JeyD/zsqiFNOhh89Lao0SB+teFC/syLnDm48oL1D8HX667XWcUy+LzEOxMp8ewiOlcj/IXlCoMP/t8aonuPN65D/+DsrubkV4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWAcmb3pMp8CvP1WoxEniENtTQdTExhyQaymeRG+2aU=;
 b=y0xWYega6a6dtR/LTKIIkn1QWPqFr4B9g+L71iFUBESp20+I/C8DayjgYYg+9nCIVkWL914BMFt0M/CD5yFvbsYIaSaco85EieAMOgvEHBVzbKpO3wcc+MeX9p7dyVzT0Aq5KDylsaouyrqwBnm44rWYTbTHPHYTlo+IQgjHBHnxPs3FMN6LBa89nTXilkNQHoxCIpcR9GeQrD7o66ziaQE3axdpc9sbNnh8Ofi11h9iSWVrgQOPZudhuN2WF9/h6E+bXF8xBXt5AI4/dhdPAnl0JF6+x+79M3JvdA5bhPjZ5d0vYH1mVgLiTMUCqIN0unsYOPzHLL7q+A8Fm7xIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 07:56:18 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8922.037; Wed, 30 Jul 2025
 07:56:18 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "kao, acelan" <acelan.kao@canonical.com>, "Luck, Tony"
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
 size calculation
Thread-Topic: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
 size calculation
Thread-Index: AQHcARutltp8VFr67UKnYaFhiZ8S4LRKSp5g
Date: Wed, 30 Jul 2025 07:56:18 +0000
Message-ID: <CY8PR11MB7134149FA7DF6E6C0FC7A9BD8924A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250730063155.2612379-1-acelan.kao@canonical.com>
In-Reply-To: <20250730063155.2612379-1-acelan.kao@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|BL4PR11MB8824:EE_
x-ms-office365-filtering-correlation-id: 33782c2b-a582-426e-603a-08ddcf3e9136
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qf3JQkdVKCsfIe4olR61B8lnT0RqwLDJzDgtbzKz+os5CtNiqEewffvA88?=
 =?iso-8859-1?Q?2lXPCnF1hzwpGM/fp+dly2ybzYh9XhZws2FctHWZGRd984ymZTEf/lQ1zT?=
 =?iso-8859-1?Q?K7VysgqcrPatyyDCA/TCSz0H8u85fy3/Kvw2Rzi51zazryqH7Ck48MLcVi?=
 =?iso-8859-1?Q?slMj6pKAUam7Tgye6KdThVQMOO57Q62aH0wMgYQfj9cBuyFVROW6WFanw0?=
 =?iso-8859-1?Q?Ceq6kgD7j6Zbd7x4vEUnXGTMHsX7Jm7w/WPkBTLELsR2Rx6D/C+FiIOro5?=
 =?iso-8859-1?Q?Brvuu+3LCOftcmteP8r+GeiqFLVr11vp6L11vMeUsF+qDObP3hKl02DRlX?=
 =?iso-8859-1?Q?v8S4ETl8SAUWEPj3eDQrBGVoJvIgMXr5gwd3EpfQoCmnXdX1RmLD/DPeKZ?=
 =?iso-8859-1?Q?jtl0VFEd+ysH/YzLDjRdc/ZF9Un2XtUhUgLsjq36cbzIRt/aRZ0FTWcc2i?=
 =?iso-8859-1?Q?F2m4yqiZh0ShAqML9R5CxdU3HY0oF2YE4LmJ2xzdxaFQrWbqfOM6xNtfny?=
 =?iso-8859-1?Q?8vtxhtXdvZQi8l4OkIh7NjHKBMYvxQD3SxDZ+GffgFZFg7l7/rCWqDhEF9?=
 =?iso-8859-1?Q?c/xb6JL+yLTXSJaibxmsC3r82Oklrnwz8CHGpGP+QFy2sloFK0M9m8+HVN?=
 =?iso-8859-1?Q?xrtajoq0iBfIUU7jUAbs78SpAcsbaw9Q02Z5xM35Q4FRmvAr3QljvbE8k9?=
 =?iso-8859-1?Q?gcdwcX3CgokyIxwpYrNZWs0YUE/+BLvhAXw9ST4Ghf+lgP+4zoYQfoKg6n?=
 =?iso-8859-1?Q?bq0t71Jr/JlBEm9yidFaxb60iG0hjVq3yJ7VBSm8gl/DCLX/pLUgc2eqgk?=
 =?iso-8859-1?Q?CidqdHglE1qYOjujwnRvXJsMGjMtR7L3BmNe8Qo8vBeIiO9qEgVWIAkWzK?=
 =?iso-8859-1?Q?SOCTXMQGhUYViMzv7LD0kQK8lJZzxhvnoQlG+IdQ3kws5S5BA2r9/i7Ij2?=
 =?iso-8859-1?Q?LJpf+L6vfM66YXMqWJ8MQl216/xFkqsQGYd1AzGFe9FNaNyzvKyqc7kDxz?=
 =?iso-8859-1?Q?fWoUB6ovXTx3ahDAoLU8wW3T8+BHuCVP5uLMqD1+QCvQmhcu6IP36nRIyX?=
 =?iso-8859-1?Q?7Re3QnAoBJoHzWyTVtBuFAXycqTVymtLcrIfVxSWUsRwpK1N6swQsdx3EY?=
 =?iso-8859-1?Q?Phk1MuRNvT/c0ZFPqnkdI0igFJIxBQQCh4wEgVmhpIBefSdtzQbOtEnwH0?=
 =?iso-8859-1?Q?1iMbn2BZ+DMZ9+xZew7Xc6IuEpzchNBKTGlwR3gvZuk0ojpr7mGiMf7DzX?=
 =?iso-8859-1?Q?whmV2l03gBx++EYkdGAhnqPpAM+y4Jn0ffxhDZaptR/JFTq121eCckxLdb?=
 =?iso-8859-1?Q?t4FwR9VnashP67nDfd8jjBhbS29Xie3fjr64Y+yTw+znnnQSta6KgRnmwY?=
 =?iso-8859-1?Q?gjukD/vjB/ZOnQMLtQ7TEwXTo9lgLCz9rBxujz4C5hmSdUpDXtB/fw0a8x?=
 =?iso-8859-1?Q?5lhfz8l8h1M66yKqqIbn2MKznmAJjgAdsWVX4vVXFND8VjcMiuTLXOtyOn?=
 =?iso-8859-1?Q?kbmPXmZkSDxkhrB+Awo8PtI6NL8p9xDbmByynrZqQXt3O/Ks5JOopg4Hah?=
 =?iso-8859-1?Q?b4/chd4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tReX3QqR2NPLA3l+sDDhvKaoaCRr//6AlzFZRYPRDc7+Rzld9mx3BRndhE?=
 =?iso-8859-1?Q?eYrWmDEHfqq0V0i2NvHF5j+SVkyNMKgomYgR/hQ7nV+hsrw6OK0TiUC7GU?=
 =?iso-8859-1?Q?McNcGZtUXBu6FVV60d/NouX4dEt/etRMGmmEDcQQ0XF+rJFA2x0SCUo+SW?=
 =?iso-8859-1?Q?ucJ3VIVZq30ldvDzhuxc3pm9ncKc7evXjdkKdC6jwnAszQ4vO+CCst5OZg?=
 =?iso-8859-1?Q?kVoSxnqmyambhLfLtpOjeV5LMXSfdLzgxUZflpRzn6uDSrwMEww/k1ePyt?=
 =?iso-8859-1?Q?mhnv4TrsGur0tcUxG4u+/QC7qevpoBwwshhVxwbrcKFrlcfwLRrJp0ToQJ?=
 =?iso-8859-1?Q?rYQwsVZEeyWpZlE15c4nE0pCBIWlT9uprHVDM0M/ZlgyctyRjw6lo36wwE?=
 =?iso-8859-1?Q?CWfFLldq5MBahvvIF+NwAEeolUjxVvtetH+TeAyKZVuhvwwNYmAxE+TSb3?=
 =?iso-8859-1?Q?99VOjp9FeR3gn8nMtuoThKDkBAdmJ4AoLGxrgLN5/9wful/odijV77Gyx3?=
 =?iso-8859-1?Q?Ccg8SakMddsrw6CCZ1KLL3szQ3eVDECzpRAqMTgkB13lewS9rKDKGChVXK?=
 =?iso-8859-1?Q?LGzeAolzACjuARS+uYId+HjFNIJgSrZq4j8iygsdOzTYLVbqnKcggyEbsW?=
 =?iso-8859-1?Q?cFmZ5/sKIezv1+4sbUXkUw0XhXDiUDsV88bQVUdcyhc3dH16mSk7gv2nRA?=
 =?iso-8859-1?Q?UecO5cPIo4GKCWeBMMVaef965HLH33qvj12M2Q2iZTVsGAizqKvQog8ntM?=
 =?iso-8859-1?Q?67qn5d1tAQj+ml9qUmsjDQkl5CEcZ0h1fCVh7D95X8uR0DO1i5lqSbP+q0?=
 =?iso-8859-1?Q?RPPXtMu8pnJNOy5cxKBZatnvSQyCP6ppEgyBSQcg0yEhJuiCUaEyngFMT2?=
 =?iso-8859-1?Q?gFg0E/dskX091oi2j+wfB5Av9x24ps7mGiPa/ZIK87ndVTqyYUgmbtuwgA?=
 =?iso-8859-1?Q?9ql7ZD0zNTTolYKABGoVwqiy3F4/BD4MeECXMuJ0nR+Jn1yX5ZuZc3KesN?=
 =?iso-8859-1?Q?oa5B/3vB4jWKEwXjjsjlnpNPhAVT43eUBj8SCMZ9Wd+TdMfLIx5/aVFSlS?=
 =?iso-8859-1?Q?tGOwJxy96FWP0QQPjszgG0Xej5y+hdco7nh16nRF1y8lELYKbK/3l9pkFG?=
 =?iso-8859-1?Q?z8d4yYy2VRhxR+3+AIlvkivRW1elAOgIH5Qv3JdI2EFZPMf+tSDg1z7q2c?=
 =?iso-8859-1?Q?N2VlIhhKs2DIPUiPCeX0t9hJJGzvAHHkvUu+2m0PDon8OhwYw7gPaESddC?=
 =?iso-8859-1?Q?rQ9Ws1eoK9Jp1w1vj3JT48r2osA+2ZsKNhnOz7cA7JiRvj0XGhkYngnX7L?=
 =?iso-8859-1?Q?vD5L7AOWMy6I1He6fSpj8DkVHbas2pczP5O3ZEK4JxBHh4bdFe49DHSou+?=
 =?iso-8859-1?Q?08HLiVHdOl+c2fX/reUbhEy8DCUCIqrTBIjrHKBpwIwaJHiI9I3Wv0TcaO?=
 =?iso-8859-1?Q?422xAeI4l/iIuOqdk7pHzapKuzkWOwC3BM+ewlxAHx2YnhrJt/T7NMyUzA?=
 =?iso-8859-1?Q?N9iVv5vWin4sONYhNiFbF0P/EZeH0Tib7jeFy185Tj/xHbF/92B7Zq+zBi?=
 =?iso-8859-1?Q?uW5CzIZYRxl9u/Bq+jndXmEQS9UH/KyYIv+Uhvbp/xj8qvoGofsO2Pjo6P?=
 =?iso-8859-1?Q?HpWp8W4Dd539i/NG7c9SGBW5D80T2wVEhd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33782c2b-a582-426e-603a-08ddcf3e9136
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 07:56:18.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLCTusAlvy0fjjWymNuWR/ocmfcOpa1mzcYK8n4Wc3ULWKgMvM+W6sX881xIsW9eUdAPJRCkUYDhwRnZLwPVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

Hi AceLan,

> From: AceLan Kao <acelan@gmail.com> On Behalf Of Chia-Lin Kao (AceLan)
> Sent: Wednesday, July 30, 2025 2:32 PM
> To: Luck, Tony <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Jam=
es
> Morse <james.morse@arm.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Robert Richter <rric@kernel.org>; Zhuo, Qiuxu
> <qiuxu.zhuo@intel.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] EDAC/skx_common: Fix potential negative values in DIMM
> size calculation
>=20
> The skx_get_dimm_attr() function can return a negative error code, which =
is
> then assigned to 'ranks', 'rows', or 'cols'.
>=20
> [    9.344702] EDAC DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xff=
ffffff)
> [    9.344703] EDAC DEBUG: skx_get_dimm_attr: bad rows =3D 7 (raw=3D0xfff=
fffff)
> [    9.344703] EDAC DEBUG: skx_get_dimm_attr: bad cols =3D 3 (raw=3D0xfff=
fffff)
> [    9.344704] ------------[ cut here ]------------
> [    9.344705] UBSAN: shift-out-of-bounds in
> drivers/edac/skx_common.c:453:2
> [    9.344707] shift exponent -66 is negative
>=20
> The 3 values, rows, cols, and ranks are all -EINVAL(-22), so this line
>    (1ull << (rows + cols + ranks)
> would become
>    (1ull << ((-22) + (-22) + (-22))
> Which leads to shift exponent -66 error
>=20
> Add a check to ensure that 'ranks', 'rows', and 'cols' are not negative b=
efore
> they are used in the size calculation. This prevents the use of invalid v=
alues.
>=20
> Fixes: 88a242c98740 ("EDAC, skx_common: Separate common code out from
> skx_edac")
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>

Thanks for reporting this.=20

Which CPU did you test it on?=20
Would you mind taking a complete dmesg log with the=A0kernel option=20
CONFIG_EDAC_DEBUG=3Dy (your current log showed this option had been enabled=
)?=20

Thanks!
-Qiuxu

