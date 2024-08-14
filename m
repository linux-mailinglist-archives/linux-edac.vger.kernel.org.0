Return-Path: <linux-edac+bounces-1645-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A9951B48
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2024 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9C4282132
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9EF1B0115;
	Wed, 14 Aug 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRvUzokg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA3143887;
	Wed, 14 Aug 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640336; cv=fail; b=mESwAY5+Lr8grF6Ek72o0hhWajAx50cQF8lRnKpByb41FpE9PN2wOuQ1WE8/AkmL/qyKgv5o1PUx/cq6In/ucGEqd9E9rWK9cYwZe1b4id8GnPj2bmMD/sLCuwmvy8W2IFYESoC8uRACYHx01X08vQ3aIqukP72iHHxAnNSjcsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640336; c=relaxed/simple;
	bh=4riDCHgW/PCEQoVYLj2hf63WPEZ/2+A7Ov2IKaMEUFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bARZMTh9OTleODs16OOnpT4lt7/Eyow7GBWhdvKYq4Vy822W89HhNq1IDGxNVg9vxYb+MK/rZ2PU9pEkOYYgpPNg6sKMV5hme1e5VNFkzNwSTSdCBAB3MJmzyuJ16LEi7DtgijtS9JsPbKYq37C4axvmHGQxDB4blX2AG5wVz4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRvUzokg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723640334; x=1755176334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4riDCHgW/PCEQoVYLj2hf63WPEZ/2+A7Ov2IKaMEUFQ=;
  b=hRvUzokgb0kR6UJYjliAmt8SG/MU0VFjxM2cYqavmPUfJZqqvU9FRQev
   b/IXqy3HlbBNu8QriKzBBI2Rbc7xz0YYe1oq/DbF/m+sWmSqXEsFHfpGi
   t22Ek/rs5hD0UULQ544GpKZqxqpwn0iZ8crEv7VyE2dhV9sgu9g3X07uO
   vr2xQljJKmzFCEPa57u3YgZa2G6MrcfVaNsefoMKasQOs3VFlYF63JPCM
   o9bznEUmit+aNzIx6E11vBN+jS1PkenFEiOB6fc68d+PzrQmHqCsG1mSe
   LKTp83vQfCBTcF5uzFiNhrRtQmwRPtOq6V3jpDqLgYOOwZ53SUobn37xi
   A==;
X-CSE-ConnectionGUID: wdjQ52+7RPyqsXQifdnI7w==
X-CSE-MsgGUID: krkKTKP0SxWHsrWO3ZWu4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="39305894"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="39305894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:58:53 -0700
X-CSE-ConnectionGUID: kQbU6abRQRKeUp/ReOE5FQ==
X-CSE-MsgGUID: T1ieXNpnQwWJzN8IbCCyiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="63857681"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 05:58:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 05:58:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 05:58:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 05:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkMu2gXnUbEouti83PBBS/NuUy9wKEvdSMY9s7nxibgMhLiKjMbZooetGNt4lWFKwbYaxtex+q9fxV7UIxIR3tba2ueqKB+CWBsm11hmNzbiZiQlB0EJNbYztS8cFUERPKkEqsOdT6HQuWGqfRl65FlcV5cmVDT+Fpt0uhVY2+MQDqYCcXxu7kbsVALHwRQZo1YnVmMpDSuVQ7YeejCHcO2G7bnTWgFLLDyh7lMPpSSDjZpjrIw9zzImklvhzULg/tX7hUK8WFO2zmQQVl/V3POduL5ttyNaxkd2OFEyaaFgDn10WF+nfn4Hk08t9IwIPjIjpA68jfsTv0iYrxCcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4riDCHgW/PCEQoVYLj2hf63WPEZ/2+A7Ov2IKaMEUFQ=;
 b=hLmKufEyuc8TEcGC0Tc7zV2wBxCZRQ/QqbIoOAAIPmx203M8QovfDxzl9FmFHOzY05DpGtgOJXpBSDvkOO59NQyZpaaAZU3EtSFfbgOKvJgdQOU3xMpdmIuaTkgJGkgVjlD3JzeWGam9P3dlOWYFvjsBSHh5AnQEJI762Zsk5tT/cLsVfq4Herpr77zSyBHNKmGs8onGsw9RDI/VRYuLJ3g21f3iyXjF6oGAE10plhWq5AwvJxJ7KM+pPZ/DKHRp5fbV0ee+JnGwfFhss9V9Z7XJFb+Q301HmlIvlTE6SXT6KRcQODzuMSoOXQlcNim+BqnraRQl40B7dybFJpZ81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 12:58:50 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:58:50 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix conversion of system address to
 physical memory address
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix conversion of system address to
 physical memory address
Thread-Index: AQHa7hKAs2PfrdHSJ0ObOvlDiXpkSLImS2cAgABkczA=
Date: Wed, 14 Aug 2024 12:58:49 +0000
Message-ID: <CY8PR11MB71342A4DBD70B6978D4E637389872@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240814061011.43545-1-qiuxu.zhuo@intel.com>
 <2024081442-pureness-salutary-35ec@gregkh>
In-Reply-To: <2024081442-pureness-salutary-35ec@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY8PR11MB7241:EE_
x-ms-office365-filtering-correlation-id: b32ffeba-e214-4686-155e-08dcbc60d7a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZDhTdUJaUVBTM2grMmJPWDBqVjJTN3ZyWmI3MGxhTTVZR3o1V1Rtc2wxZ0RB?=
 =?utf-8?B?SXhsWEJQcVhua3hqbE45Qi92OW41UU4wSDZEQ25MZEtpYVdtelp5elRYTjhn?=
 =?utf-8?B?YXY1SHhBbmdsSlBaTjhUd2ZyWlZuSjlzM1RHUFlOY0lUSlBvRmFRWE5mN2tv?=
 =?utf-8?B?YmwyNDVNL1h0ajlqdzFzVkdJOXZVdWhVUitJM3VmSktFa1VYUm5uR3daaW52?=
 =?utf-8?B?TXZBZHdkeS9nZEdyTzAxdUNXVllyaDRCTEpESXBiTHJWTm9Sa0FUZGR4Sjlu?=
 =?utf-8?B?a3Y1QytGZlZlVzlOajZFcHdhVk1rTnpuU2ZvU3BFSzBoM3BCRGtUZjlFYktS?=
 =?utf-8?B?Qk00eVhyUVBZMDZJcGgxOThseGNYV0I1aHEzaW91aVQrYlBSQWVtaHFoWTFY?=
 =?utf-8?B?V041VWF2Tk1LRG5LOXdnVUhYSkVCNHVYU0c5ellOaXBOcno3Uk1ZRERuVTBO?=
 =?utf-8?B?NSt6dTQzQ0FrWnkyNHhOUEpBS0E3SDVrWTlhZW4wOGVPd0RacjJjdFN6TjIy?=
 =?utf-8?B?MTVVeUpHN3ZYT2s5MGxQQjVCSVhta2FocUFkaUJwYUxoSUFkT1Y3SlhKREIz?=
 =?utf-8?B?ZloyeU82YlFrd3ZnQnhzUTN2d0haR3ZrSkdDc0hjSXJwYlhWN0k3TUVvQ2x5?=
 =?utf-8?B?RkZZNTZCZlpsVmV1QmtjOEZXUXBILzRoOGdUL2hoY2pBZm1iRVRmcTZvbXVx?=
 =?utf-8?B?Qzg5VlFhbXMvRUFmRkJrbEtXMlRpRnR4d21mUHlNVWY0YWNTV2dULzhGR3Iy?=
 =?utf-8?B?RHE0R3NxQXZqRU94bHNCaUZWUnVKMExlT1p3eGpkWUNRZlUwejFmaDlBdEVM?=
 =?utf-8?B?dEFtbHB3cTF6Yk5DSkN0SGgrRllVN09XNXhiVXZTRGo4WUV4dTdiRENhM25C?=
 =?utf-8?B?TlJmZEkxL1c0cnU3ZkRRdTFMTVBGMFArL1RBczd2ZGwyVFJuTHZnOTNBcmNh?=
 =?utf-8?B?Tyt4bjd5MnVPdWdpNW85Mk1MaUxENGl2ZlVlYTBIeHZlTFVja2NlTklXVmk1?=
 =?utf-8?B?UUkyRDZFWWw2K0tna2taeUZRWWlaNkJWQ1ZqZW5IMTIzTm9HdEZ5ZDU1V0V0?=
 =?utf-8?B?UEp5WGRaU0VFMlZ3L2FadW5GRDQyaUludGs2VTVQY0JPdTArZ1JReXdJc2Z0?=
 =?utf-8?B?TWJoQ3JJNTQrUXhybHBvSmEza1pXM0Y0NjFSK2tmR0o4TkhaS0dvdmFJK09j?=
 =?utf-8?B?azlpQmlnbGxyNG4zbzUzemNoMk9GVm83VlRqOS9VdjgxbS9xVDdlN2p3Tjcz?=
 =?utf-8?B?VlBQWkF3VEpzZFdLei90TDlLK3JLbUV0cUE2TXhGUnU2NDluVUZRTEFyU2lK?=
 =?utf-8?B?blN1Y2o4djEvamFDMEg3bml5ak9nMHJHZE9XcUNFOXF0eXM4SEpEWGNsR3pJ?=
 =?utf-8?B?TTkvdG1Id09MR0MxaENiUEJBdUlWUXZGdUkycjllaVdLN2o4Slg1NkxMSk1s?=
 =?utf-8?B?RExUR3JnSDViT0NxTitpVlR6b29JZ0NiVjJRZ2ZTTVlYYjNUVit3TXNNeWtN?=
 =?utf-8?B?Mm1OSEp6K2RJaEkvaXJ6Z1ZRU1VidTRrYnFtZ0l2TDFBU09JN1lVRWFJekJs?=
 =?utf-8?B?RUtBbDVud1VNNnQ0ejh1NXQvWmlLc2MvalVLVFNzcGRiNmM3ZW94bzZBSURp?=
 =?utf-8?B?U1pnUTh2VG9nYTVpbExvY0FBY2pMSGQyQm9wQ0J1SFZJWi9mRG05K2xSdW8y?=
 =?utf-8?B?cFAvVy8ySkVnODBqV3NqbkVOUWk0bFR0aHFXY3V6S0V2QUJrbkptd0Q0Q2dE?=
 =?utf-8?B?NG1JWFBRdVkrbnhYcWliaEs4bjA2OGQzTEJuNFRMYTZoWWVtd0JhNm9QSG93?=
 =?utf-8?Q?AsXqW4Za65kqhAacwar6iiE6sTyoHX8DfC73E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FjSmpSaGIwVlZLdnExZlI5VTk2VVcvWlFESWVUSkM3UnVmU2RhaVdTa0V4?=
 =?utf-8?B?UnExZG9vMW9hUS9BQ3hMMTBsOXNNdG5iY2pCbmJOZTZsdVk1Qksyb3JqL0la?=
 =?utf-8?B?Nk9PemlvaEltVWZqd0ZqWFZKbzVHZG1zMXdQN3JhbWdOMFlaT1MvaUdrU0du?=
 =?utf-8?B?WURrbko2NkcvL2pMUGVLeVlQeERPYVNqTzNpY2lhbkZkSitHbzBVQXBYRFp4?=
 =?utf-8?B?MWw2ZUlTNXFmUldSZE1CbWp5VzI4anMwdGVtVHFXbmJrSVRZbVQwMUlaYURC?=
 =?utf-8?B?ZHhORG0yVE1rSEFCQVRkeDlvVnd4NXVoeG5aeklQZEN1MW1CQnB2cHVsSkRj?=
 =?utf-8?B?NS9wV0x3QjRvOFlvK3VUcTRVbU14bFh5MnZLdU91bWVaSUM4WTRFdWtZQnRH?=
 =?utf-8?B?SWN4NEU1MjA3ZmdBYi9qMk9BN1RJRTBqTFRzV00wUkNOKzdQZi94SWlkbEd0?=
 =?utf-8?B?ZjY5SmdGYjhpL1hEbXJwRmNETlJEZU9zbU1hR1ZvT1FOek4yMTZGTkowdld1?=
 =?utf-8?B?NWhGSzRHMmxrVjFWWlIwWVNDZm5TdFhVM245UExOWlIrQmFUME9yMXpyVWpx?=
 =?utf-8?B?M1lZZWEwT2YxeTNpd1dCa2NyMWtNcmpUdDR1M0dkdFdkOER3YmFqKy9CNDEr?=
 =?utf-8?B?RVNMdS80ZmNBSE1tdEkyYXNCVk5KVlVFSHY0dEFjK0pHU3lsM0ZvOWtsL0tO?=
 =?utf-8?B?dXlTQlRTN2ZLYjlCVjJadG9jTzZVdGV3Y25LUFlhcW9RRnVqRkNUTjNGVUV6?=
 =?utf-8?B?bWJ5czYzWVV2TTQrL1VValRxVXlWNkh6UDljVFNVcVgzRVAzcUhFQWQxOTQr?=
 =?utf-8?B?b09qME12R3pnNFJzZFBkQmVRRTNZMlMyTEd1WmlNa0JuY3A3YjlXZ1Mzbjl4?=
 =?utf-8?B?bjhFTWxJczF3MkxlWmUza2JjbzdGaS91TVljYXdWU2dTUVR4OXdxR25aQStR?=
 =?utf-8?B?Y3d1a0ZDd3RNNEpYRUtCSlZERk95ME5ndGR4cStvWDJONVFrcExOOVhHOE5z?=
 =?utf-8?B?REZrK0lwUkRRcFh4b3cvM2dPQXB3ZTNXTGpaSFBycFRiWlcvVUZBOEkrVHVD?=
 =?utf-8?B?UURSVEhybkhFWXovUWtlS25nVUt1dUJPS3pYUUFWeVZ5aDRPaHIwbXd1NUdS?=
 =?utf-8?B?eFhsZ2huUldlMFM3S25JeGNQa2luM1lrTWNqeG9NM2pWeTcxYTgzSENiNnA3?=
 =?utf-8?B?OVRheHF1OGFuaFFsZ0dTNWdGOWNaLzI2K0lhNHh4Uk82eDkwYUJib3R2N1dG?=
 =?utf-8?B?VkhNMzVKa3ZqdXJ3VWlrR084aklTbVROTHRHbzQ2UTFlaWp5UFhwdmdpeGNr?=
 =?utf-8?B?NlpRck5uNXlUYldONlZsZ3grbjNoK09mWkFBanBUYjl3N2ZaazJ1bXRDZ1FL?=
 =?utf-8?B?b0dTcEdua3RJNjFkcnlxZXlKRUpXK0R2UThkZ1hCZVdnWTJQMFZmRlZNbGFz?=
 =?utf-8?B?SlBDVkg0SXVicXRybVVsZ0RjSk10QmJsUm10bVBnZUVSWVdINmVkMThKMjJS?=
 =?utf-8?B?aGRJN2pubUJWSllta0hLSzhaU2IwNkRzcGNFK0xsTEx3RDN5eXl3NmVvOWg3?=
 =?utf-8?B?NmpTcDRqbHJJOGQxdG5CZk9aci9PNFNETjFXWi9UaWdYMEpnWkU5RHpYR09T?=
 =?utf-8?B?T1kyZEFYWENnUExrKzJKVWVoelYrSmxEWDVWaS9KdXRxTytKQ1lXaSt6OVR6?=
 =?utf-8?B?TTlRQUlQcmc1MHU5WVVFdDNLcWZQV05FY0t5S09OUmpOa3htbXpUNDRXYmt3?=
 =?utf-8?B?NDN3eVlVQzFzL0ZicHA3MWo2aG9VWlJUNTV0cXpmMS9SamFETzJBc0I2VWly?=
 =?utf-8?B?VXFZdUdPME55Rm83S1g4dXdhenA1V0g4aEZOQlZSWFZZdXRkMEZKZmt6WUZq?=
 =?utf-8?B?WkdPWFBDaTcrdGF3VjlkS1h1TXduWXpLS08rREVCeERJa1JvS09xZDZTcURq?=
 =?utf-8?B?Q3dUTjR3U2d3cVUvYThJZnBPRkZsdldNS0cwSE94ZWUwWitHWkU4ZHp5L1o5?=
 =?utf-8?B?SmpGbUluZnlyMHVDVW9MMGl0M0VCT05Ncjc0N2ZKVGpNUS9XK3ZqaWREaG9o?=
 =?utf-8?B?VElKMXZGdW51QUFiaG8rbjdGQVpCZnRZYmJQME5oaENMaHNRcG9uUGpZV3JF?=
 =?utf-8?Q?Vrrl5FLWuGnkF+waGCIpdt+cf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32ffeba-e214-4686-155e-08dcbc60d7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 12:58:50.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5z48e1b0UqpIEEsECMIr+uQ68xmjz6TjcFgEgmXxzOTtr7kT83sa6ZnNUWN9VrckAwX2N8svVGP687D0sjcZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-OriginatorOrg: intel.com

SGkgR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4N
Cj4gWy4uLl0NCj4gDQo+IFRoaXMgaXMgbm90IHRoZSBjb3JyZWN0IHdheSB0byBzdWJtaXQgcGF0
Y2hlcyBmb3IgaW5jbHVzaW9uIGluIHRoZSBzdGFibGUga2VybmVsDQo+IHRyZWUuICBQbGVhc2Ug
cmVhZDoNCj4gICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nl
c3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1sDQo+IGZvciBob3cgdG8gZG8gdGhpcyBwcm9wZXJs
eS4NCg0KVGhhbmsgeW91IGZvciB0aGUgcmVtaW5kZXIuIEkgcmVhZCB0aGUgbGluayBhYm92ZS4N
ClRvIGF2b2lkIG1ha2luZyB0aGUgc2FtZSBtaXN0YWtlIG5leHQgdGltZSDwn5iKLCBjb3VsZCB5
b3UgY29uZmlybSBpZiB0aGlzIGlzIGJlY2F1c2UNCnRoZSBwYXRjaCBkb2VzIG5vdCBtZWV0IHRo
ZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCg0KICAgIiBJdCBvciBhbiBlcXVpdmFsZW50IGZpeCBt
dXN0IGFscmVhZHkgZXhpc3QgaW4gTGludXggbWFpbmxpbmUgKHVwc3RyZWFtKS4iDQoNClRoYW5r
cyENCi1RaXV4dQ0K

