Return-Path: <linux-edac+bounces-4698-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B7B37F07
	for <lists+linux-edac@lfdr.de>; Wed, 27 Aug 2025 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3189B5E4C7A
	for <lists+linux-edac@lfdr.de>; Wed, 27 Aug 2025 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4A3451B0;
	Wed, 27 Aug 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwFuCVWi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F722538F;
	Wed, 27 Aug 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287739; cv=fail; b=Z90RcZK+jVL7pjRK2/o7sbnos4We6C7iRSNKc2XoJOS8MlO3f0ARocBXXJjv0agXtWlApwgDMottkckMVlfXiZbm85WXbMPc1t2fE3qFx/mCcZiHmwgjhY05PxvcXcg367tOa2z9zAbpLProVpxE/n2gim0p95XkATqhvdnfI/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287739; c=relaxed/simple;
	bh=gf+KgP3BUOVuI9m+PV2Uz6VNF43rT3bC2saVuVhkoi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pGDX0ebv7NSykuoxDzuehdIMfMH7Rdr+rPcfig9mvMn4koxC6f/2tR5fqOi0zHuz6pxQu0b2BAKS7MakRT/g4403159Dc/LqL/yvhR4WcGxYj9dmfQR2Ym6Mov4xqJxjoCwMpFbub256Wwu4iHUV4RgOc7aDY7cD1pRUTOJ4nMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwFuCVWi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756287737; x=1787823737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gf+KgP3BUOVuI9m+PV2Uz6VNF43rT3bC2saVuVhkoi8=;
  b=iwFuCVWiaIZXI+Duzybq8CNCVM10qEKqxeVfp3Rk0HqOzH281GnP+Fw+
   ynfSv/v4+00rL2jnePaGYgyw2Khvfi7YOYqu+U1TEwIpLZP1lhXujv3RD
   7iUSkszcaR56vXKbDB/X94kljFVSVrxpX6/73h6l5kCTDCA+EhhRC15Kr
   KWGFJmo+QvEf5Qm/cLfnOXUMqB9UHYcAaLEqut2E40Ko8M9M9/gWFz2tt
   +rc1fZajG/TLekfITMc8MLESQ6WHv6dbBqmPRZ6keX0ejx4az/V4AcD/G
   gvgoOm2soLYn1EPAqs/ZCkp4WybaD/NKZxWl0ZpTo19PwwYHsRDPiIch3
   A==;
X-CSE-ConnectionGUID: ygViFWWlREqVMFhTbrYFpA==
X-CSE-MsgGUID: +LyORJZFTr+eAHieStkN+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62374188"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62374188"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 02:42:13 -0700
X-CSE-ConnectionGUID: Tyj9YO6UTbaOqF4MrWywCw==
X-CSE-MsgGUID: tajqToE4RSan9hqyTIJsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170630861"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 02:42:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 02:42:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 02:42:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 02:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7vSv6pb/SIwQH5zc1glfRgDFL3EWX3RjxUtJL0rjXOAKJDpz3eXoD5jO06v1c/Ihd3eTADbR9kv0cWzsXraYIa0xOjbY+72pmacnqH5e21zlRCtnQBV16k90RCEZU75G26jSkwIi5l7wPXJBg/J4bVDSGJoP/a21SNLsSUjV0ddxfnOEL75k65Py0VBYEvfAs0R0roVB5FOWj2IiAc8ycI0dK1yN5IlNX2gzPf78Y2GlbAZr0a6nFMOZv6G/VxQWUoZaecMkpVyYTfROc7Ezd9n+KOAFBKnu8fGAwpdN5zxvmWdkehGX4eoW4uTq5/nT0RDWPU8Hrl1eyd+Mw7G6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qautTc7/6yAbh5udx6cyzFsNTSt8elyQzGI+pL2vlNE=;
 b=rukdiVNWmXuyhSZienEZ4Hs6QBl0/JjQOGF+/Ums4pDCemJJcpX2mXPKN8z7+rd3D1kJ9sodoo3uspS/BI898Tsu5J0bnEKBz7hqwD1dC8gxn6v39PhTBCXSECOQf24yGoEZkN75Z2o26q9WCdMhYS8H9zp8SQ1odbaL7QOCivGOnYohoEbsUBUs7izuL04sLz/G5ASeZ2ueHjf/udGn/uR+pmBfreJ1vN22eQqZ21ODqpQHpCOWnsySFqsk7GZwM69W/V08WeFGGAeBjAuIV7NC0E8NPtREdxugHkFvyoHZn5NHrwNqtvy88b4hAwr339WG9ad+I980Kss+oRm1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Wed, 27 Aug
 2025 09:42:05 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:42:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Carlis, Matthew" <mattc@purestorage.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>
CC: "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "Preble, Adam C"
	<adam.c.preble@intel.com>, "Govindjee, Arjun" <agovindjee@purestorage.com>,
	"Schofield, Alison" <alison.schofield@intel.com>, "Karkare, Ashish"
	<ashishk@purestorage.com>, "Amstadt, Bob" <bamstadt@purestorage.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "erwin.tsaur@intel.com"
	<erwin.tsaur@intel.com>, "Wanyan, Feiting" <feiting.wanyan@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "Rangi, Jasjeet" <jrangi@purestorage.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"mahesh@linux.ibm.com" <mahesh@linux.ibm.com>, "Carlis, Matthew"
	<mattc@purestorage.com>, "Saggi, Meeta" <msaggi@purestorage.com>,
	"oohall@gmail.com" <oohall@gmail.com>, "qingshun.wang@linux.intel.com"
	<qingshun.wang@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"rhan@purestorage.com" <rhan@purestorage.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "Kuppuswamy, Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@intel.com>, "sconnor@purestorage.com"
	<sconnor@purestorage.com>, "Luck, Tony" <tony.luck@intel.com>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "Wang, Yudong" <yudong.wang@intel.com>
Subject: RE: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Thread-Topic: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Thread-Index: AQHcErztfT80IygGUEKHNugx9d8DuLRt5WuQgAD/CQCAABeCAIAHSKYA
Date: Wed, 27 Aug 2025 09:42:05 +0000
Message-ID: <IA3PR11MB91369348644A09FB6F6BEE789238A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822165112.GA688464@bhelgaas>
 <20250822181520.12394-1-mattc@purestorage.com>
In-Reply-To: <20250822181520.12394-1-mattc@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7068:EE_
x-ms-office365-filtering-correlation-id: d3e20131-92f2-454b-9c43-08dde54dfb7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vQ0CJhAlxqW0uEeNGdLehV17SB0l1ZvYj1gWa0HsakBFXHN3XgSHSDmTV03j?=
 =?us-ascii?Q?k2OPaJiNGCf6dl5y+CYWh3uicQskEdUic3+cN9YRo3724CbYkCvOtgTVCGe2?=
 =?us-ascii?Q?U6rJAMVIVO+G+/Xk1M7jzaHvnPlBNkGxrX6p9PrB3BDXjPJoPHEcEzgj1a1E?=
 =?us-ascii?Q?k1YvNFsPCCTO10zbv0jAQIIY4pWwY4Od4bypDqAYl/AdwfqdQbgpXsoDaZSB?=
 =?us-ascii?Q?Lnvd58hhyfdHxJVXratdqI5GF8Kl6QE1Kb4lt1nNo1QfPw/LG2K8y41bG4y7?=
 =?us-ascii?Q?aO2WwbyT1kFeNb8bo75Ip4S6jh7Jb4nPAuCzjVdSvRP5YVRZuuZMENBSjqtB?=
 =?us-ascii?Q?tkyY0oDYVnTYX5Jun9Rg/MFRwNBh1diXDcRKMZIruUf7/k0E1UbTN2zeMfdj?=
 =?us-ascii?Q?NH1nh5jrYN9LN/rLDEMVqud991VgXnxjZ+bLItb50RKB4rhTlSe87imeP1sX?=
 =?us-ascii?Q?puN1CK4SoZR80kZrEL1ipcqxBl5xy+Y17ykWy4DTY88+WoM3XY22oVAVdYIJ?=
 =?us-ascii?Q?E+MW+LB10FA13CHWm7rn6+nCLWEtp2nGMYk0FnF3O9gHvMvQCUiETaUuecn2?=
 =?us-ascii?Q?b4J6b3KuDQp9qGBHWfFG99x6KwlpneVK9sqKgmK83rtxT0GgBBOKmF+ZMHyk?=
 =?us-ascii?Q?m9SX8mHne8MicfmjvESd9kul97jGoPuBRlN+jFG7/eWJkwUGuekvLU9aZI+0?=
 =?us-ascii?Q?qapBYPImq9ZTLeNkCvknR4F/pIGB/hcIeXY3DY7ET82DgzOnYZxcOcJ1j5sf?=
 =?us-ascii?Q?tCfTXEQcEpbPcuw5fwJdc5F5C+XKPjpm3gj6KDDQW2tXqY5lrpEEV/zhaxx/?=
 =?us-ascii?Q?qExoeCzZsl6ztpoF8+Pg+ZiTx/orXdtnq0OUMswchKOG4sNVLG47vr1LTlx8?=
 =?us-ascii?Q?YyuHfNK3FIe14CV+44NAMicrc4DfLDmr99q94PWlDf1oATzdbXD4Sm1IeAQo?=
 =?us-ascii?Q?8mOCSAbi0x0VpP4JIR63EfvJ47VIPgouOFKqXI+dTRwXir8QfOnFmJWdL6RS?=
 =?us-ascii?Q?ITkdJ2/PG3g/RI00igEdRmgL2xwVA52OyogipsAfp0owwcLzaq4Dm53f7rqd?=
 =?us-ascii?Q?uggWS5OcPKh3KgtK22Li3swM083tSUz+5HuetzA3iftrBIp9n8BdW+wiAO+o?=
 =?us-ascii?Q?6wDluAWCy7eT9urf3edNBmiFJfJ1zfy4DqnnSPySCj5btYp1RRyOLmAMm447?=
 =?us-ascii?Q?TojMGuM9ZY4+RnnvBhCa5BBZPdFI4WkYQWp3IE7njcwj39tH8GgAwGvmISPl?=
 =?us-ascii?Q?N/52Q1MrrUUlft6rLC1Vq7BfRMobwCYY9JM0ox1/4GNaUAyFWaTwGY08ARs/?=
 =?us-ascii?Q?tCRMNetMwvF2xalY2sP85r6QUfI2kB4qv+yY8/jLYlpZcfHrDpDDYRG/240S?=
 =?us-ascii?Q?kKl3ePf7zbEKXRM1XQQomq+WKhhdIcf48mw8kLERkS2k7C9Zv3Ryalnh4uIC?=
 =?us-ascii?Q?lS+JzBIDS/8yZu0LSErVZd4a1ui8J7lgmcXEJTbfVA2dO5KIXdwxeg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7grpRf+OXmy6SQ3NRbaTZcyOvD66fxIuJEv7L4HxfEmvZF8hMMwVV1k9c/t?=
 =?us-ascii?Q?Mk/c6lCVPMZ1Nx73c+yckd9QGHaHgXe0FVCLEyIRwkejFmimtOtnAnsTIIs3?=
 =?us-ascii?Q?6rxUxFaPszxSywT3ZW9BXGrkNqmKvDku5Vq/1JP28IcOJscGFTBwAoofbVLX?=
 =?us-ascii?Q?BgY5VxSYg+FwGc9pSOczy5FWB7Grvpu1+soGixyBJtE+raTycv0PWiReri9b?=
 =?us-ascii?Q?L6lM1GpzRNyO1RUWPv0QbffJwP8ydOc/y4oGZ+B3m6MC+sxDZMadOQFc7EC8?=
 =?us-ascii?Q?IUPANSVCiXoqzdwUup4U7u1D9KSM1VW7X/5zUET/3cbJzg9dAnFAl5i+00Nn?=
 =?us-ascii?Q?13UzQ+pFIuLdNhnc253pwbFOBL9OMtQzQn2kfEVL7n/sT6v2sLGb8xBZrSfu?=
 =?us-ascii?Q?NUNg264Z3n01mcMC6GIp3B97JjhDSJsP/ZFvhWy/3owvtZjp9OEolTYwm/G3?=
 =?us-ascii?Q?w7Zi2Ww3WN3ax3OD1asiOkQwu1aZ9VjOZfpefFGunkljUODn/dRJGfbRDe0V?=
 =?us-ascii?Q?xt5Zrm09E57g5hyheNF+xKE4+IUbQ9qA+q3SAv5liPOomOSxLTQn4i+bilg2?=
 =?us-ascii?Q?U8oISzlpSTZKIaDXUz+DkJJ2lrLpu2kEeKx/pD6EhtUJOrLxIBPWrFYyhbrP?=
 =?us-ascii?Q?LLGymPmoNBR2g78Q0O5uFbW2KcQ4kZov7HPLTLzr3zHnZvrQbuIYqLqE7+8e?=
 =?us-ascii?Q?HPcmbtucopTzcapsGGSBKx5dNvVdU5pgHBKwRwq7DaWStbtYrs1jq5A4f0Q3?=
 =?us-ascii?Q?MRHwAE3r6GO/hsxwt/tqPcG0Ir7An/sE+QQ/R/62XdOh0EiOSUbtu3dmuFvT?=
 =?us-ascii?Q?SYtX800S7aqdPxBO4aHJKb6N7xjkK9TSavuAe0TQa/Wo7I8OeO5nkWnjPLhq?=
 =?us-ascii?Q?/6af8+2gfOW9oRSiBae5MsbGAWgnkoD3tZToEKZYaBk6eCWEU+ksdBn7guc6?=
 =?us-ascii?Q?BivIvIVHIB3wpPzGdWlXZ85kYLdZkV30aivWW4ZV4R5XlBvFWgEl9EI85g7i?=
 =?us-ascii?Q?/kxPc3DqKWXQsEGLy9xFiDV0CZbhkyLl5qO6d6Jdc9UIWt3nEituxoKx9y1s?=
 =?us-ascii?Q?8Dcq6DqOCkIPQHIozQcO2Wob6hJJNT+wEqyR+Njm+KhomI0kdEMBr7cQqsv/?=
 =?us-ascii?Q?Xv5xKNZ7VaV5/zNrPKxApO5dVOG+kcgbHEOiqsZ9tp4MlbONoZVZDhcyyPrR?=
 =?us-ascii?Q?UdQZYKuC2KcOhF5GhMzTmYrTp51fVWwuFjp5/6xRoAPDuEgVvXxk34q+u+z3?=
 =?us-ascii?Q?jZc8Po+Rl6PCuk2w2XQ6VDsYMrxcIgbIQ6HxAtQjWBYq0I0iuuIVbIwt55w9?=
 =?us-ascii?Q?g2BOSyfF3D4+NGQOvxwMa9ESx8vKEOOJgdYgbXrVcVJE/9UsloWDFkhH20rW?=
 =?us-ascii?Q?vouM3HpAKabSm6DMueWrvq2s7b7r7sQNCCDgBo/fbktLngN6q+0vn0eBioWj?=
 =?us-ascii?Q?Ii+BhlK6dg7AGGpjW+Ez7DMdkMQYT9iywNS4+eSFaa9WtvaTt3TMFwdd8DCZ?=
 =?us-ascii?Q?JVtzhYsjQONgjb2xbkNEq5SV5OrJd8RxuanOofGOElBCUBl/d9YYIPZ3+U5D?=
 =?us-ascii?Q?9RHlm+tWp/zPCl0dVENcvOclS1+zVP96VED873NR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e20131-92f2-454b-9c43-08dde54dfb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 09:42:05.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJs4AOJ7lPSpyjsjaHAdy4L/dl7nPH5mOaKIzyN2UITE5+nRo8KsMh2G3zUGhHpXvgCMgBAeJapv29UQyMNygE0SR4mGFzUfHFfBQuTFduY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Matthew W Carlis <mattc@purestorage.com>
>Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
>
>On Fri, 22 Aug 2025 11:51:12 -0500, Bjorn Helgaas wrote
>> I'm terribly sorry, this is my fault.  It just fell off my list for no
>> good reason.  Matthew, if you are able to test and/or provide a
>> Reviewed-by, that would be the best thing you can do to move this
>> forward (although neither is actually necessary).
>
>It seems for pci there is always a massive list of things in flight..
>Difficult for any mortal to keep up with.

Fully agree, never mind, Bjorn.

BRs,
Zhenzhong

