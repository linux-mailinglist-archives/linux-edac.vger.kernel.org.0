Return-Path: <linux-edac+bounces-1166-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886058D8367
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 15:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D15E282922
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D312FF6E;
	Mon,  3 Jun 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rb5WskJD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926761EEE0;
	Mon,  3 Jun 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419759; cv=fail; b=gXmOd9s3CVl4gW2//NF0mb+cVYLZO01j2vK8SnwGFlSIpnJgyHMUmxY8tStVqNx4N3a1Y1ZQ/AC/R44JGU24vmfy+fFLh+nIM07URyWIhOl3gidBo3vkSvBmujqAMrTO0F6aRyRHAsLP8Y7qXHkkjlWhGhSYnA5EZTXAGVVXeME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419759; c=relaxed/simple;
	bh=dbvh8VLTFOVVZqHqQIwwiuEIyM50v/XE7yte2lPhoGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYktA/ExO2PcwFxhA+/e0mZOFphwak2hBRB0R8v1GDtaTbTktLuAdyd0KPZRTwgsKIozAB0gj9NgBGhpOlWoSlKeqnIj3hbaQ0wZnWcg/s4poC84gZTZHrceeIZugrKUHiXiRSMvwyU8cCmMoATcFSJ1pSLScEKL9g9euxeEh0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rb5WskJD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717419758; x=1748955758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dbvh8VLTFOVVZqHqQIwwiuEIyM50v/XE7yte2lPhoGM=;
  b=Rb5WskJD5z8AT21FKGgAQvxeHCeoqcAig7k9odIVBzdysT+fr5Ke48Ga
   hpJWIdEdQpTCwE1H6CU/QtyezQB5ye8KxxwjDIwwxBZENIGdSQSk7H7ab
   S4tVlHFTTRJ7w413+1LHXfkbr1kFP79ZNITMOrLbIHqR6Ch2oZI0Bgwhl
   /UriS244xp5NDk/Yq0jYaA9ogW/FrtOnblAPC7ulVQCD6MZj7/Uj8uqJa
   DDVJfC5se2RLhC+t/1ExzFSsAKybCwdUwCgULiBuqEZHWoYrvOmoql5Na
   qdktTrjZs/If9LeOn1K/EwKTcvqz0seccTz5QeAxFc5DC937RvzpQrgmU
   g==;
X-CSE-ConnectionGUID: jRbaFY9RTZemnf7kynXGwg==
X-CSE-MsgGUID: 4olIWmZ2TJCXhXqWQTt4dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14068898"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="14068898"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:02:37 -0700
X-CSE-ConnectionGUID: 25l847vVRYOu2cPgXJC+OQ==
X-CSE-MsgGUID: V0GmQUOBQEO7TM+fCvB3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41316962"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 06:02:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 06:02:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 06:02:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 06:02:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 06:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu9eNE70V0tLJidZLx1w859P2CFbWUOVsL6VTpK3shUl+AIRTTegQDJD5PnuGhc3RUEBfnlVR7qMwNhW2RJ93c0EhyHRACcMX/MRMXjN3BFEQh7qTKJhHlhUX2x8U73oQ8noImtiq+QWhxo6RvGF54BPfQdwznMH/+VuNL4Xt5bzCeE5HVD4Hj2nfqZmVmXq6hB25No0ZaJHW/L6roONR2swX6P3NON8QNdvzikFx9mKUbVhOL82ASfJtqlFS1aFjwYBvvJVyn/Izx8/8GYX4Y8j2UROgRQeLl0UGeAyQSvrXFM0ktc96ZPx3i9CsfJfliFJz4JjEcek37mn/xE9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taBf+RQSJ7p2Iz6/Li71OcC42Owl2YKOP+g9UATq0Jc=;
 b=GEMdWQB7bl3IkSqzelUsI69HtmP1880G8GJFveqaXzKO7GWYccrCtOGOH4oGy5cpAza2WqBMExZrt9+sHFfqLU2Gnz0QUrsO2Su/5MqpsOqCjeHBP2LbkvpJO8HMskPP9+n7pUbTn1O46reEoabcMwf0otl+QqsRTbpiEJ0vImF6Mdy6Un4589wIaVKsn/Zq89SB58v1F5YHmIPLeG5Y9bOGM99lfG4mflC6wO/mgzFuy90xQYpkS7ZwqyngCavKNq9oMPeuFK/lc63zZJ6otbWXiLCa7oIA6TgVoWEGCGXHWcUB0cQpO54m8L692AKSbmhdw7KViLU8v+b2SYnZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 13:02:31 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:02:31 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, "Luck, Tony" <tony.luck@intel.com>, "Arnd
 Bergmann" <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Marvin Lin
	<milkfafa@gmail.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, "Sai
 Krishna Potthuri" <sai.krishna.potthuri@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Thread-Topic: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Thread-Index: AQHasa3aksCJcLTTrE+3snIA9cs7hbGuY0qAgAAB8QCAB5hEwA==
Date: Mon, 3 Jun 2024 13:02:31 +0000
Message-ID: <CY8PR11MB71345BD92CF809FCFA5E890D89FF2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240529095132.1929397-1-arnd@kernel.org>
 <SJ1PR11MB60838B76940188104D57E53FFCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e526fbec-5fc6-4778-b46d-608744a4d7f6@app.fastmail.com>
In-Reply-To: <e526fbec-5fc6-4778-b46d-608744a4d7f6@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6917:EE_
x-ms-office365-filtering-correlation-id: 87000779-4362-40fb-7624-08dc83cd6df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?iWneWYujUgDiyhi4oHVq6GQbFU2JmgI2hbpY8byCx6np8KSQ6kFZjGzRzHrg?=
 =?us-ascii?Q?E7PWb4GlIMPFS+iz1N0H8eBTaleocJjd861K5kX1RgftEuAOkZIYQ1tUQT4Y?=
 =?us-ascii?Q?PaEOdBAGdulWAvP2cEVrip4ByP0U2KSBDjbC0TaJELEjLjNgRP4dL28WHFmA?=
 =?us-ascii?Q?KPNW5Zi0QKEYZ/MqjhptK8bCtxPTI//pOruwEZfjfcLxPlIBuid8MAASy5N2?=
 =?us-ascii?Q?YgrsZHSzGqdSqXi5Pe4SSgqkvD7WdoFMJbKolb9SyDpZr0/5psLyQFmBuv4P?=
 =?us-ascii?Q?KRgLEENuJrPNWEqnDCyR528ndP8o62EPV+d1ZUFhVPGfx93tb4zA2bxBGsEk?=
 =?us-ascii?Q?TGy0bfx/8iU6fOFIxH4i5gN3m0LzSK9xMAdG5WxygRHHr9SlCyGFwWg26EvT?=
 =?us-ascii?Q?ACfieTIoirSr7ZMz+nQAti/Y9m9OoleyvNSGDQTJxgg8lH1Lg2qzZiYFTAXn?=
 =?us-ascii?Q?j39WyWkKeKPIYe2E5dswwcgTd09H1f2OuoMU4eieELF2f+QAbVesD3Qgdr0d?=
 =?us-ascii?Q?6hUtVlQrmYRaxUgvwnW+f00hquMHqrq4i80Zh2nhu/jfkELm9PEXSxYKX7TG?=
 =?us-ascii?Q?08IM1rfhFIjKAG5VNjUCeMQNw+CqRA4h6V+XbBNZiT0c1JLHeor7tKhuKpx0?=
 =?us-ascii?Q?UZBbjj38sm1re8jLN16JujyT7tCNQdy7w2MHqRtH2p7zBcNbD99vSrvgnejW?=
 =?us-ascii?Q?DBL6mfGArxvq+uPLvJrCmzIuG0MZMMaiXQBWIKD0tN+9lgP4IYapm+kLHk54?=
 =?us-ascii?Q?KqX3AzTbHsw48GkIHi2/YAJZinYePFIQ8ZgTpoOYUJAoeuCWgwhKJzPoaTPf?=
 =?us-ascii?Q?hgN/PurYRME+D4W06+JLg02y90p0O2dymXEfyIr59Ky2WXn7oW7WvK4x+ylP?=
 =?us-ascii?Q?SZDN+GKPx7RRzLK/jJNaFt+5v4NxPaoF11zyU5Jn2zcAEEVeiLmM2bwYqJYR?=
 =?us-ascii?Q?tvQonmB+cWT7PImkVIiZO+rzQHHBJlRb/FCxwcfbpbsrUNpcPSjvx0bN1r0Z?=
 =?us-ascii?Q?LFY1iIbJjxcrVramruXRnsJX5wDNpQ3TaucyKEa/ZwV9SEQEJ1DXhBnKVONB?=
 =?us-ascii?Q?wPD8Fga78hIoMtKmHq+tv2povIyteYDZ/R7n0vkW/J2jImQ5+QQmY5jZE30c?=
 =?us-ascii?Q?fhUXFG9jJjxXIckO5PVwvLJZOYtAbGcb81QoodYMojIIr6p5A94Ns/JLaQg7?=
 =?us-ascii?Q?jiyOe0bHzX1yelD38xXXv+wo3KnwylaF+FsXGbVypMEIxbBV4IMYYLfQJHaW?=
 =?us-ascii?Q?/gwPfs7heoiHOIay3Y51OXiRQmxJpeLTRmgf9JLU40mdh5snxYLHKR3tQtOU?=
 =?us-ascii?Q?uuRjOLAHZS+rrOaBObzo5OwH0gO3j2rJSwHXKI50ZCyiaQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4ip83QCMHR4+cw4FjH1+GECqU+UnlZThrA7SiTMEIqHjQOLdNlB9C8Iolml?=
 =?us-ascii?Q?kPQScXiutioCH4iFmcwLtegD683MaRCcU4N2bnVDj8p5xD75jtFE5RL0a0NA?=
 =?us-ascii?Q?5DhevpQ5PLbMEzeG4LfEZNxfAMdY7TUl4uApOFwN636ZGZtr9lVzlwz0/YZw?=
 =?us-ascii?Q?iMKyH32SPZXhQ0bJuMTzPDki91SD13OngbXe6hGT3aSzpwXwHO0Um3O288g+?=
 =?us-ascii?Q?U3giqXVvc31EfBwz0uXdpqymtlA+YiS9L2NWOYbPGNzC8dZAn9vkrG+aJhho?=
 =?us-ascii?Q?eWgvdSvZYDHUrtjXOMJqmbQCOkQZr/H9nFUQ62US2TKTyac6nPS4aTf5BCVa?=
 =?us-ascii?Q?bcsuSeiP4so/XyH997ByhVX/Uc80lt2u5+ZJc+ybo9IA5O8SGm8RLpxZKVMR?=
 =?us-ascii?Q?dAKJ4PcdxyRCj2qOWB7GG4fCYy03JtFSic7UZRscmyFfViD8Xgd9KyiubqTZ?=
 =?us-ascii?Q?/4ftoNKDKWCLeIK2WcN9ea5SGpW1ej+BpcLRF6/YsRIiUBDrqsWfA7ppt/I9?=
 =?us-ascii?Q?8VB1X5ZxLggEITSS+YrORGHfLLGEg67s/Qj+ssnK2eqX19xVRdrexzeh4wPB?=
 =?us-ascii?Q?ZHztxMCIMMIzJ9zYUwogPcM3e5q9ZklrfJiN6nnnIbTKJoIdIDpdjgjNlSpi?=
 =?us-ascii?Q?DDoCsN0l5Ug+DzsoNJO2+AY3lLYcZ7oCACdcTIlvAZ2O4sVymgG0JkPmGG4l?=
 =?us-ascii?Q?7nXpT9gMeO+hf/KBNr4FeaHfIPu//d99nvtgU//ld02YCcQ0leiYIVT9j1SC?=
 =?us-ascii?Q?aZgQHNvTjM0kSgPYrIJthMWcaFfMoaK6HjugUombH2PEtqRhL7eyC2LGEYox?=
 =?us-ascii?Q?YqLLb/SK6oZTFO8J58rbqWCxadTt6mwUWcANU/23d//w/1aVDguMIAiZnaDu?=
 =?us-ascii?Q?OttbI2CSa7OalSni0Gge5Rzvc3XmXflW7MrJoSafzSDRp8uo8dxXQGIZDYOY?=
 =?us-ascii?Q?J/0OqfV9qPPAD08gGuJ1Xq2hTGofTWB8bZ0t5PIpDKVITgyyTP5eikx/Whwk?=
 =?us-ascii?Q?eD4gIvgTgRaqORS4RdyKqfCL9YmgDjIFyte0I9t30Dso8UP79OsMZytLpp8Z?=
 =?us-ascii?Q?sV8OMNigggZ2N/GqxDBvySx+Iy+QC/aqP+KL64lHNjbQODc4++MH233LarxB?=
 =?us-ascii?Q?7PVEZNDrz57o4ow25MKkK3KJB/QkPpCNZc1bM/iGHtcHtRMuXsPRKEp94m2f?=
 =?us-ascii?Q?2xtXvbEsJO8Qez7B2XWJ1zsTKKW8vT2cExZD3RBctbm67sxA/OYKz5h1olno?=
 =?us-ascii?Q?Xbw9pF8w+E89XZ2C/0L9JTj8F+q7fuJHF0GY/1GlIdWqgkC7FtmHpNcQr0YE?=
 =?us-ascii?Q?WR/HD7o0RnIpnL7COGsZFsvZ3Q4tDXNpaxey9niShpxohl6f6JDdRoqqXtxz?=
 =?us-ascii?Q?4SNlY4OjEkegW4e6dSYOUEsBWA4L/K5fvylnu7DqCZKShywMq6xgxav6590B?=
 =?us-ascii?Q?Xy/58zKvXIMl6yAPf8qzK0Ou2dZeByQotZuN3Htg30Ra4TlVDseopirJtMyu?=
 =?us-ascii?Q?Xf/5yiDF8kbnxemy8vw3s7l74pixTwodoDoo+85fcTFjADHlG6ZetcXnUdPz?=
 =?us-ascii?Q?nsWSwlhVnY6YLwFe0pYO1QPVUM+5ilP4dBR8XEkq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87000779-4362-40fb-7624-08dc83cd6df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 13:02:31.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7dshMpqD6QH0fqa30PtsE3Yg4r6SLPxx2a3OCeuRqASZIogi8KKowzrK0f20HS8hpfpCmuAXo/kD9rNHXVQuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-OriginatorOrg: intel.com

> From: Arnd Bergmann <arnd@arndb.de>
> [ ...]
> A particularly bad case happens when one of the two is built-in while the
> other one is a loadable module. In this case, the module infrastructure
> assumes it's always built-in, which can mess up e.g. __exit annotations a=
nd
> THIS_MODULE references.

Hi Arnd,

Thanks for looking into this.=20

I re-verified the following configuration w/o your patch, it worked well, a=
nd I didn't see
__exit annotations and THIS_MODULE references got messed up.=20
This was because skx_common.o was built into separate two copied texts=20
(one is built-in, and the other is in the module).

1. Kernel configuration (one built-in, one module)
    CONFIG_EDAC_SKX=3Dy
    CONFIG_EDAC_I10NM=3Dm

2.   Build OK.
      Loaded/unloaded i10nm_edac.ko on an Intel Sapphire Rapids server succ=
essfully.=20

3. Symbol in skx_common.o example:=20
      [root@fl31ca103as0104 ~]# cat /proc/kallsyms | grep skx_adxl_put
         ffffffff832c7da0 T skx_adxl_put                            <--- sy=
mbol in built-in kernel
         ffffffffc094a350 t skx_adxl_put [i10nm_edac]   <---  symbol in 'i1=
0nm_edac.ko' module

Thanks!
-Qiuxu

