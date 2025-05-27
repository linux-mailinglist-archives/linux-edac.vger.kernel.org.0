Return-Path: <linux-edac+bounces-4004-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0172AC5C39
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11641BA12A0
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 21:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821BE212D7D;
	Tue, 27 May 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvI+B/W4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084220C000
	for <linux-edac@vger.kernel.org>; Tue, 27 May 2025 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381541; cv=fail; b=W07S8HlXq2e/5tTMizO35R6BxoXIUI5LWxmqlFH6VbslfDsE1DP44IlRl8UtDizkLKa8ZmBEA2AWHAqOjInr7MKOgn1aU3NMte+oQ8o7AhI7HULurXA6zWlB55S2KBUJYi0LsFGvBjqLxqDz/yFK2jL4qV0AfsgAhdvHD6qzKPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381541; c=relaxed/simple;
	bh=jV2Un+BWL9PWsO4K5tw03DEzicqNBvHfq0+SRLnkCpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3LlQhDnSaWPE+BhXUo3Aq0KkMMimed8Na16dhFHipSlnJRGNl4TCIhFFMNERqnI0TfsQxPXDUK3za1boHlq6cKAwgDiEZ26LmA1X3OsVX5Skk8JnXUkZdGOq0AeD+KgHMXYAelZQuP7yDDbLyxFdM3HH+KkZhMX7mdicHgPdCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvI+B/W4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748381540; x=1779917540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jV2Un+BWL9PWsO4K5tw03DEzicqNBvHfq0+SRLnkCpg=;
  b=LvI+B/W4v55ciH87scDeb2OiDfA+nMg47DVtQIe+AiJmwun7plL1OlqG
   3Q560Ki9RxMJGzD8w3mPRwQME2xtJzlGG2Qk56TRQZVld+ctu+CiX3rHZ
   6Dox+6S2hKzNdOdogGiWQ5uYsEFH9vc6ESe3mdZ1+xYfBYM4WAZb9e6Uu
   szUGE7J7j/LbfXTf34eMaREqXYbCJiC1SeniSGs8RuNckkOU9FR4g6TLZ
   hNpG2IkaAcia8rIAFxgiILcUgo5eAk6ggtRUtRY0LuAnveijnE3civf0M
   ic7a2YZEnP74WpQSQI7fAdJPTKwl/pWkepOnet3HkvSUYORdgyTQ8L2NW
   w==;
X-CSE-ConnectionGUID: 95GqDSf+R2GM/NTO6K/UHg==
X-CSE-MsgGUID: HJAhIaXyQsCp44wYyXYKGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50448574"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="50448574"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:32:19 -0700
X-CSE-ConnectionGUID: KBLy3urkRcSl1XlG9AoKFQ==
X-CSE-MsgGUID: jxPySUV/SUWbw7qIG/neDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="142808085"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:32:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 14:32:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 14:32:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.73) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 14:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXv/3GZOP/lI4w/OC27chcqoYnndfvdfalipX5jz0K+nto6+EgmYiCfusSAEAqeZcZMiNv15iyKLWxNvEIcaQlZeXtgu2Kn1U/kRms6kS348CcvAktnoCFcyCMTHYqI0zODwAe+f6AErriT4SA9H+pzGvnkMFTldmmpz/lfOjhl1jObrDTXJp/zEZmkQOravfh/sfLXcs0xDoNnZT2z3uCq8SUCF2cecNcwCmdeiURzyH8N8rgrYl8XB7LaxVAcgRSAtG73e97ZthSicuKQ6VZH+j7e0+XaReLlxdztlxF3RHzVtIGFRnZBvVzzNXkxcttfEz4y7BHjc+1mq0ykPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxXUXbSgV299UvzvsmtRbX262nqt74dkFrIXJ2qzq4g=;
 b=j7Mhk6Wn1NIfwhRhf+AKWvd5j1IXQOFsTiblkiAmEZFVlIj3Pq2zjsljuH2vkAF4n6xc8qdMhJMcPFkHUFbgW/8D5UdeWMFzxmLkc/dyMIEA42R/pPSneYUAVOhb3FaCk/fqZJTBsghYp9peDna8iFp1CWLxnyqUs7LAYqSc4K0pBOXTk30OR3Xiz7powhp6PPzruvjDmjj7qo3datihez2M1jfqED6Ys3CaV6MO5f6GlDWWwftPZ3RXUWFtsqqcXNEvnBW3hdC3fXs8HTTFmSaD0b2J4MmSlHAp3iYRQH9JIeCPFsK6tFiYmvpGWST4bW5/qcxpJr2MxcaOh/Sa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 21:32:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 21:32:09 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH mce-test] run_hard.sh: Correct test name printed to match
 actual execution.
Thread-Topic: [PATCH mce-test] run_hard.sh: Correct test name printed to match
 actual execution.
Thread-Index: AQHbzurYVFz4BH2Dmkuo4EPMVr8hULPmhfEAgAB5lUA=
Date: Tue, 27 May 2025 21:32:09 +0000
Message-ID: <SJ1PR11MB60836F7D00F24AC9E5144AFAFC64A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250527093448.157-1-rex.nie@jaguarmicro.com>
 <CY8PR11MB71342CC625C146A36D754F358964A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71342CC625C146A36D754F358964A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: 30a46db8-66fa-4a3c-ef85-08dd9d65efc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3F71CktHJRrIXK4EHjILWCl525HseEtdMKtPsuOGqPWaoZ72ryodE12usOaW?=
 =?us-ascii?Q?dAsdYq6dCTjdLTyKRPN2OnFlrp+uk/G7zqv9voJ3gKPjwJuseZJmN0FpSvvu?=
 =?us-ascii?Q?gbenxmolk0K93cUa1TLom1xZeFGEbEY1xV1wJseadZPvOsSC78IcuKxUsfzh?=
 =?us-ascii?Q?46waW0J6jpcSXHEdLsqLnE7pswhe3XGpFCxaf8DAEkcQbYn6RZ/Tuks0OxZQ?=
 =?us-ascii?Q?1R54PZuZoQCnZnDdFV8b/7s6h2ptiqw58TDh34RWOrci/GUNyoMfX5aahS7r?=
 =?us-ascii?Q?jlrtaBXx8oclMmMNZgVrjRlDkLmN9YeGM7kN7xfo+BY1Ko/TcLPoH+Kdl40v?=
 =?us-ascii?Q?3jesPEjlvhy9x2La1gooz126v1RaM888Q2VHaK0l6rB9fsM+Y0aFbNmBpddK?=
 =?us-ascii?Q?mnonxOOpga0CmDbz2npcqgwSXcmF7toPvdOfSWbkwiZufv3T+Qz2Rxd0MZ3H?=
 =?us-ascii?Q?KBN/mTBNmvRpGONlYlgQogvUidB4h7LCD2vbNrv3P0M1IF29w4AKNMaNOJ9i?=
 =?us-ascii?Q?iGOK0GUZvU8RCtxAkuOvFgmxKnhJhSAsaOdQGXR9ANTIXnrnFQu4ayuCvvAu?=
 =?us-ascii?Q?Noel6cUQQRgs5DAXhIXtpASAPsBFr8kv2+LEyVBpY+oMuRMLrZYI4LBxRBX9?=
 =?us-ascii?Q?E/lVTjY6TKVCtwjyo+dHtTE4TkV9vgp1HKnHN2+LHoyjGjHVSTJd8GXGZ4hS?=
 =?us-ascii?Q?awmpDRktxZktcEzHmh1nlJ+dOVBo5VNNeJTg806SjSQqDNvezKWUlMkk5YnG?=
 =?us-ascii?Q?ScxO/mUKBPQHl/BIbyyy5JIDVxXlR+wexgFTe2caLs3ZQC5574GCUupoDVrM?=
 =?us-ascii?Q?ot6BeGgDxY1lRIGyXYjkKt9GGekreM1ck733hmLXYSNmzLTAWmUS51DFDHyd?=
 =?us-ascii?Q?0cwuDZrdYgW+r8ttz2jLQq4tJWZBXJ3u61x2I8SvOhofLvJtf/Dns6h7QUBu?=
 =?us-ascii?Q?TAg2o2Rc0x1C1RJ3CZCek7JNH4T9IZrBjRWNqsk//xCOPHGaJk7bX6C8lKgQ?=
 =?us-ascii?Q?X2X+9D/ig9gX13OTJCPCV8ZE2O5IRlsNRP43t4kJmffwn81CPK9KEpYpL1OJ?=
 =?us-ascii?Q?XIIDRemvOyaWrPi0Fb5VME40aV+GMKxPAH9SQaGg4q8s/z4srydA3/zikOks?=
 =?us-ascii?Q?Un8C9mUNqZZQ63/UATaau88EbAGb3fk7mn2AfK4TmXr8XEzXBN/E8jpi40pk?=
 =?us-ascii?Q?XroktQ4vHN7EzIK6g3yhEfKJ2srNFRZagtputeFmV9jDnyPhjdAS8SAgU+M6?=
 =?us-ascii?Q?uDEgZRgyO6Q2egG6HPzgXHVRfVkJ3mgW3+cbygwYao7shmdzesZDXFRUMVVn?=
 =?us-ascii?Q?jxzJxVDVii7YPAwNFRLnas/pqnudILZ2YnbGackh2CZ51GzuCMuA9mFGOI8A?=
 =?us-ascii?Q?4KaMRMIsPUzV09YXweIrZ7eckciiirGmaPaprlPS0YpYv14NqQRiMVrmFSXD?=
 =?us-ascii?Q?9NqsP8h68tUZICxKUkBKDj0LB9H0ojpjdb8EO+d+wOJRW39lLj4aLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Ba2H/O7wvvglcPJgnfbjNLy7d4HAN+Cgqk+ff94dGcdlchVlf0tfyIwTPbP?=
 =?us-ascii?Q?AnwKVL2x6VkB0JKZxbDfPnAY5Y68mnD26OndwE7jRxz9l7u/THMam4awLhcn?=
 =?us-ascii?Q?RioxaQh5a75e2Tvh3BK+2wbFckHO3hdmsXHr5e5jl8C75eelZ92X/nULZFsb?=
 =?us-ascii?Q?iedqLzwzIcSF/R9D2ALgtcmy1GsrdHkQd5BAEegO5ZyVwT6VxJsUBuIfOt/S?=
 =?us-ascii?Q?RlpQQTaw1Ixh8yR8tE8T09v8mz5HYGAD7m+8PCl8PDA33R0nkmZmhaJwbLQh?=
 =?us-ascii?Q?5DDlUJyM2VwB86DRV/YXvb/0pRyRAfMs+CIqamR2hlKSNFA14uj/t0QE4hZs?=
 =?us-ascii?Q?zqg2ENOqlpDNQpwmW9xMbbLRO5t1d+jIjAl7rtR+516E2/u1QYSC5NapIpU+?=
 =?us-ascii?Q?d2R5WRbYyDNrZBKkGPLc7+72L8rTXkGAzEVzme8cBVR6U0db4RoaFjRz7gKd?=
 =?us-ascii?Q?VPym795Yj303IeO/zOkpZQOo9/8Ycj4TdDNDvt6ZTZOncrjn0ECG9bK9oxDc?=
 =?us-ascii?Q?A6oaTrzveBQxmfnMLFZVoHvWRWs3mETyM6Jdv4BMd/SfngQL1pfYj6EVat/R?=
 =?us-ascii?Q?DdJB67Pm6AuX0dBFLs59vfg572u+672o8ipAV/ue6LBoiMHDqPNPKutDROwe?=
 =?us-ascii?Q?HwJhM5IlXGIID5Cs5df3texAfG7S5BiQtHpi029U2yR+qeKQUazbwDBactWN?=
 =?us-ascii?Q?pre+w5uHPmPj7PZhOxvQmPzduqBmsSPqKLlVywT69lwiiA0BdyjBPMzBzPQV?=
 =?us-ascii?Q?13K+EJmudl0bOLPMoTajKFt1VhklppUCcijf//d0KYaePUzQS8Mt5ellOik+?=
 =?us-ascii?Q?X7z0i3Y1LAzo6BBBJhyAlthoSOv5BNerpoWVTnkMGPD6suawSgierFS1+x5O?=
 =?us-ascii?Q?QV71WEWSH9+YMX9yKCnU2KIySfUY6eIhjNJoKLILnKquka9s/lTsnHj+TC9H?=
 =?us-ascii?Q?TGWxAym9BijTF97s1cZqeflNBCoaXbZWCqduRB2y4IT2soTRAKtx5I/PFZm9?=
 =?us-ascii?Q?RoAbdr9YuUzaKIPb+gOuIo8p4+k8nsSj5FqAwKr+McdUImu5KOX2aSpeT6On?=
 =?us-ascii?Q?tti96ghTg0yG8E8jX1bR9h/T9ixCYifHx9zPjCECFgs8iLrTVjbInqVVM5yK?=
 =?us-ascii?Q?MoaD4gQYqDZ9nZlgdaF9ZPOlE+VzxD92CR6cS2NECC1XNtwa4nea8d1DBCro?=
 =?us-ascii?Q?3fao8ToDNFkrRwz7fG343nn5Emwp9RsfPobOZpD+YoJYu/NjZ07RXV02LTCN?=
 =?us-ascii?Q?abpbnq/p4lyyEoEX0FuBlZK12LKH0L5fexdOxpm5ZWZvgjJUnQ81jKRZXoHA?=
 =?us-ascii?Q?KWcFk3cHfILmxgpQF1pHE/Ec2vT65hjCyrZfEELkhw8gMa9C/F87XcfEyypp?=
 =?us-ascii?Q?KddT9nWboBGWxlDQwMlb4KDZZuT2yR306FtZf5E9JO4z17Xg5PxtPwmGYjTL?=
 =?us-ascii?Q?HuK2EQz9P21hqbzONDkiFjrQ4hYrVYnrmpa7wy3EsORLo6rFLIArSo15ViVp?=
 =?us-ascii?Q?4lA/Eab5VvY+8CvfynYdmvWVVkFC5xaE1uyrpWY2HN4wWX7O+16wXNXHuyPe?=
 =?us-ascii?Q?0QKFmJ/srYZRive4AfDAz6GnNPQF6lZb66B02LTJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a46db8-66fa-4a3c-ef85-08dd9d65efc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 21:32:09.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OD3EJwHDuAet/qynUupASh2qnAaKN/8VjdCS4M1Fpg0pRbgl/M8MIB9G+wYu+8UAt1bLKUcM/d5G3K/s7Trwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com

>> In run_hard.sh, "run_test ./tkillpoison" is executed, but "Running tsimp=
leinj"
>> is echoed. This patch corrects the discrepancy.
>>=20
>> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
>
> LGTM.
>
>   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied. Thanks.

-Tony

