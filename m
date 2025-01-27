Return-Path: <linux-edac+bounces-2952-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEAA20175
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2025 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E083A4E72
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2025 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86B1DC04A;
	Mon, 27 Jan 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fcib8YET"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9142904;
	Mon, 27 Jan 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019873; cv=fail; b=Np9mU7Coq/VWbWSYVCMWl3rDhW4veno6EkJh6yqbLOVIpvJBVhJ0nIFkVUfliRHtfPg76oFsFdQLA4EpferIkjgAKReR5EOkTIWXRVOYgWmb+8OUTbSBSDZEJLf5qZ1O1rVjsJ4dD/7cHLKeU1F7dTvv1jSzs0IM6OPrQ27iKvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019873; c=relaxed/simple;
	bh=c9YsfENZvvtxXy63ROYRmeVJBnOz2eu1UhZQ61a172c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lj2cngYMKnip+4jR+ZivUuAK6Ni1ydJ20N8cmR7V1TOKwWn9A7LiOVzx1tAlfRuZ8am5n0mSTRhhiC2SPAWpI0ViC4In0RvbdOPOEk0+Coyud0lGLvxqcdj6AOoNcZIB2OxotfwOTLzwkNq7F//IvdbpEwZCEtPQ/HPoJRXuqJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fcib8YET; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738019871; x=1769555871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c9YsfENZvvtxXy63ROYRmeVJBnOz2eu1UhZQ61a172c=;
  b=Fcib8YETVS5alIiDQEM10DLjq0bLwgtuvcJfioWbAuT9RpAXiri1XTLK
   4e4/IjaFBhQeOlVKVDwFCbZaBCBw5Cg6irIeVJfAFU+VUv5fx/+K+7iaJ
   KBW49xURynCOXh0MW4H8KuV8RuI2/1TC2JL6jSUXYP/tXb5pIG5xXUWUj
   +iIJsOZtoGZlC+uGTOAXNUztlggH1LGK1UdW+U5bOX0KtFd9pf8BRdHWj
   5102lg0lmg8OEP+zAVF9fdu/UZJwbXBD6BJGJUa1d5LZSG/1wtYzenhou
   oBiF2dzNKi/3n1iRMgjxC28XCcbCSVsKUawxZvhAF0Dj+woDj2Ye2zsoV
   w==;
X-CSE-ConnectionGUID: yf4339RHSzGL6x60wjLzFQ==
X-CSE-MsgGUID: D4kbGzMYQbW64n0BUyl4ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38197684"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="38197684"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 15:17:50 -0800
X-CSE-ConnectionGUID: /Nm7JRzqS4iCRq+w+uNarg==
X-CSE-MsgGUID: /eFIc8dfTdKvjdJCtEUh/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108426191"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 15:17:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 15:17:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 15:17:48 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 15:17:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XScFhkMnCteQOlc+uQQNkoPpokUXJ8ntLQMbl72geIxkzdUDfC+8zfNgp37zWKpWIDwGlaSEtYyw/leEStZlYyM1rAEyv9Xc/KMpj39hJ0H9vZA96pOxgjEjbXlBh8ti4z/aCsAvYTTyMzyc99jVaZxsUJBLkVVipTu6MZtRBGA+wpXVOPSjaiihsV6BuH/TZvIaygVKHgIn4xT9gKbfQIxrv9QZmzv16SvZJTkSUJtoVDLExk0ykBuDzg60NRppYLxeVzsx8VJXNPgb1dq5bGEfXaOCapQBnlT12aF0Nov3P3un32a5KTuA3+/iyO1+Wnok2jhA97IxmRmucNOwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIM7bvK7yJTK3NmdiyHLIRPh+OtyGPFrhgY+lGLuJ3E=;
 b=xP++mGu6fhxHTLnlYcz7kG7UMC72j63rBCoSrREMkwqyMzbaqc/cK8VjkW3KW3bDLtdX6K3rT5pYZNVvnn5RbpWvCswLSMV5u1bAE7FL7ECO95sbDl/+sX6xdD+rS1v6nZIUZ0gAI8u9AoXZovqD+YEgr32quuSOgdLdT6nFBvVAAs2uI7OjJYJy9g3/+CifXclgsRG2sS1cGe5XDvrYvXtxAYLsnF6eCKtHrRgxLc35NA5O2IHLhu4i5aruVpVoukBHKn/HW/UAj0Z/dV4m902zIqFlOM/PG9vwlvkJgjmWZ3jB9nTyT+4FzxqrOLYafsguL/nVB8ZAyNfgQNpK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:17:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:17:31 +0000
Date: Mon, 27 Jan 2025 15:17:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <679814068d4d1_2d1e294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-16-shiju.jose@huawei.com>
 <6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <637fa0190fe64594954ee4d9e012c39c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <637fa0190fe64594954ee4d9e012c39c@huawei.com>
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0d4d17-dc25-44eb-5ce8-08dd3f28c5f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xRRgOQInyE2xKU5UcgqsFnI/XJUSd2zg8xk58jTAHIe+uWn2lrPl/CWGxAsy?=
 =?us-ascii?Q?OIC/oPEYY67VzZxKmHGh5rxjkm1bXhb+MlrOxqUwhdAfHKxgvsarJk/BLazV?=
 =?us-ascii?Q?NjI2Vvpu4N3YtGUQonvP6Hyl4PkHaXg8F3xbyTedXSzeTIFcUqx9YRdlR4/+?=
 =?us-ascii?Q?dEVKcg8tehzAXWbPuOkT0Zml7aQ/YXXvP+JBX80crvHJbJvgJnh9LaL7ECtZ?=
 =?us-ascii?Q?6CUz0PxdzusAw7LUSO3+5m1miFbIDdbyr8I+ZPQp2wEPa/TOS8NHuaeb63lT?=
 =?us-ascii?Q?oNcD19GK850KBRsI20OVfu8XxEDLyUBC817a4nanMh0MI2XsfAr4SRzqhPH3?=
 =?us-ascii?Q?CxdhVJ0h/sDaRSUXFvmqp52chj2tvpuhCtGhcGfMZgPo+Bz5Ock+M6/rpWYg?=
 =?us-ascii?Q?3sqLF9ZVkRNlesRm/NE6vRK/YezA3vtKRhyIg34xkKNxEFWBETmou0ImMomT?=
 =?us-ascii?Q?1I8Srt2zBONDcFEPVbndpSUd4AfP0hkInyYtxukPqIairvJ8hLJGx+labLgU?=
 =?us-ascii?Q?idhlxgzOiX6YFEfALha7lo9RI90rpJrclr8tggwbnNTfq0MqQsPVQBN3YVEw?=
 =?us-ascii?Q?Xwb+BwS6CUTHHBQ1ml31sScX6yLJiDg45c00Z98mVCPa+3yjK+wmBJ8OEWyW?=
 =?us-ascii?Q?c+ghQuFatdnrkk3F61BdSexRH2rHEb+dUL3d/WeTQYHuLLTqmU9CLxwAHOV0?=
 =?us-ascii?Q?uJQ2t8tHfuzTsvjfGNa+m8w6pE6bWg+2ydMSp5EwcoGrmiE+1+ITXOV18CCi?=
 =?us-ascii?Q?nT9+htlMAS/gyNu1NN5bh3w0RGBbMO8hw8vdwjekM+/CXADJh+cONX+n2FVH?=
 =?us-ascii?Q?nYUTMo5EfcDVpFw3gMnY+ND+At9oJeIU1k+IqPxFvgV3Bsyi7Q+NYApZBQld?=
 =?us-ascii?Q?mLtiRvYMcKeIL4p0raJ9sOCCuXBGCDV4M38Qj1qDHZcFTThn+y2HKLKuZ2fe?=
 =?us-ascii?Q?ADKqkDvbDlbon0L8j16fH0OymAt+nPglg3z42Vfl9EgLemcO/vHqXLD2Ocg3?=
 =?us-ascii?Q?Ia9zfMWUYFjEwlzR87wiiJdxREbuGBwcYA2xFkdjynVgeFZP+/1lehyo4vbZ?=
 =?us-ascii?Q?LHMW/xvbDYB8MYc+95PhZvcciske9havtUo1YoG08NbfLHM+b5yMSwZSuvVN?=
 =?us-ascii?Q?TD6whwbrxNyPfG3aGaDOulyGrQXN3bTA3CJMNVBNCMY4C2lKNDZ30vf1spYl?=
 =?us-ascii?Q?wkp17j3caI7on/SjJY/5Y2ahDI4KAA9jwHrDAEfTRY1Qqj9FYd9LiqTtkJdw?=
 =?us-ascii?Q?hJ2TyPCWC0B6+snr7994I/+S8NTjo8g7KRgY5XmQLP7L0/5OciTOQkoTWO1h?=
 =?us-ascii?Q?KROSnos1ieK4yfZ41DTLAX7sB3Q94yNmlUvo/bi14EoxG5gk2dBMm/bCg8x6?=
 =?us-ascii?Q?2RHFXWi1tSDlmFSyNxtZ30VH/OX7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92xd1ulw7k/bWAh47FN9xz3QTYj1VaeILstVhOaxHPdWDJYbNdZu312mxTkR?=
 =?us-ascii?Q?Cl2u8gPmmEqHaJ+PAFozjTSmd1FNBfCiYiLP06UvuVRB5hLpUHIk0JNjhAvI?=
 =?us-ascii?Q?lQ4Ui25il/VVR3C87gnal7JVfs1rdJjILLGDwOWFdkcE/fsivtd1taAIBBYl?=
 =?us-ascii?Q?Yfy8wDh6s980tgQUvWIUWBBPAMtAtXe21uNsGBmO0ZCI7n+7dDjn7kI0yPR8?=
 =?us-ascii?Q?NfIU9boANNgQyKx7Ppd3mTD0qZ+hmRzGyDz0MkH3zilbsLUTJJQpPK97762E?=
 =?us-ascii?Q?M5m7pubTeFVMyWkH59dAd/FqrG1g8BUwO71H4RYzoJjzc+omZUxQX8fzHMH1?=
 =?us-ascii?Q?n2lPuFugC4s6wesL8tyNwKmBBSTrYUnw6kn2TUY+NiFdj9grNV+wEy0hAACK?=
 =?us-ascii?Q?Z+SV775Yo/RnQO3NQ4qTdtQgnFkAmeJX5ceS59fe+DJ5t9j9A5+shQS8RLAe?=
 =?us-ascii?Q?2cd5tbUSiSb9hiTHIsRoonet5NgWBDCJqbUfIPdyTF1SngP5HPgKw5L39Hxu?=
 =?us-ascii?Q?p1+V95U5DApdCgxcFT7NEeFM4mXRuWcYhYE+w31RjVyUa9fYCkF8XivEww01?=
 =?us-ascii?Q?fTGn9fx5i3vGHWteK96W+6/mX//FIpT5cLfoPfMV4PXsLKA27TIROBMuI8p+?=
 =?us-ascii?Q?Y8JLGmXVeyf8h8UdQP0E4N9ADmF8HS1GCgM3/0Xf97Ej0P/zTFkZhHaGz2lv?=
 =?us-ascii?Q?jFgCtJuqaRnQf0gs/ia1RiFGG3ozBMjt+IA9+u625ZqlHXtUJ2C5yX2nUE51?=
 =?us-ascii?Q?UpIxXf8U2F1/kdd+YQWvfLdh+MdcjUse45//qmv6VgMuU4wwV5ICTsjYvgs8?=
 =?us-ascii?Q?QwG4udvDLaOYh9zJ9J5AGkbfSUcU5uX2Dj3GfsJBgV8+ZaMvfeq62LruIJBD?=
 =?us-ascii?Q?ITWFwf3PAbUQvYXWw4SECFtXF2/IXsStOtgpmrvtY1RlacSMjY3JzdbvVbTF?=
 =?us-ascii?Q?F/wfNcTFkF2DU/TQswrY0nCPTBJ6olLZPrLgQ41RsWna/ugIPyjtSq8cbhF/?=
 =?us-ascii?Q?mmT1zGLQFrb4uNAJL/kkjpLxC9o8vnB+c/tz3RsUWAWdzJP9Caui1RpFiHMB?=
 =?us-ascii?Q?VTQTymqYqrcQkrrhM7SWZ6Cb/pSqi35mNiZNFrzb62hTjzn2h6c4A16r62K9?=
 =?us-ascii?Q?2el1qgKTQe1uyUgtw3gGDE9s3KXBvd0jl5a7wzCU36HOjOWqWQqN1kSI/9Om?=
 =?us-ascii?Q?0wGXZ4om02cLpRRNCHJHknwD3SQo3sNiAPmnUpRvvquJqm5JB8mlaY7/x0IC?=
 =?us-ascii?Q?DBs5YURtwjWT6gvoREjnoMeOPM4rs40oH4Iqj6yDUzI57fkc4ALP/X+6BzZ4?=
 =?us-ascii?Q?aU+wCZJFEKp5h8IyZaLwtwi3KQCNfaoLSpdRDKXFR7AaSNX7l2zVTDg3WQ9q?=
 =?us-ascii?Q?lMincfqLSXLD63eIqe6RetCjFCexcgtP/cWDWugLuSrNsVz/yK7Ujc4bZijq?=
 =?us-ascii?Q?wlfGQ6TAxSMpK4tXTHhO5HfiiHRmhDcSGOk3apZuy+YppSL+VE2Vasiqrxn0?=
 =?us-ascii?Q?+IkKN04FSPNyYfE664LXIHRVmesd9jVvTBI5A+RTH7dBlxTTmbXKc1/s0Vex?=
 =?us-ascii?Q?WzUhWDG5siRNkR7sj2bhPeO39nClOjf+OvPAWY1vIrn2i7PFlJdLns5loCxh?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0d4d17-dc25-44eb-5ce8-08dd3f28c5f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:17:31.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SME1nHtYyA+Ps8Fx1ZSiCAgc582pSoN9QAyulUaxtClZi6cDEhtlTU9ega41Iuy8V/cCv9grebDakMzL1uPfdXc1INVKulaSrWIJZplOrRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
X-OriginatorOrg: intel.com

Shiju Jose wrote:
> Hi Dan,
> 
> Thanks for the comments.
> 
> Please find reply inline.
> 
> Thanks,
> Shiju
> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: 24 January 2025 20:39
> >To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
> >cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux-
> >kernel@vger.kernel.org
> >Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
> >Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
> >wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
> ><linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> >Subject: Re: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
> >scrub control feature
> >
> >shiju.jose@ wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
> >> control feature. The device patrol scrub proactively locates and makes
> >> corrections to errors in regular cycle.
> >>
> >> Allow specifying the number of hours within which the patrol scrub
> >> must be completed, subject to minimum and maximum limits reported by the
> >device.
> >> Also allow disabling scrub allowing trade-off error rates against
> >> performance.
> >>
> >> Add support for patrol scrub control on CXL memory devices.
> >> Register with the EDAC device driver, which retrieves the scrub
> >> attribute descriptors from EDAC scrub and exposes the sysfs scrub
> >> control attributes to userspace. For example, scrub control for the
> >> CXL memory device "cxl_mem0" is exposed in
> >/sys/bus/edac/devices/cxl_mem0/scrubX/.
> >>
> >> Additionally, add support for region-based CXL memory patrol scrub control.
> >> CXL memory regions may be interleaved across one or more CXL memory
> >> devices. For example, region-based scrub control for "cxl_region1" is
> >> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
> >>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >>  Documentation/edac/scrub.rst  |  66 ++++++
> >>  drivers/cxl/Kconfig           |  17 ++
> >>  drivers/cxl/core/Makefile     |   1 +
> >>  drivers/cxl/core/memfeature.c | 392
> >++++++++++++++++++++++++++++++++++
> >>  drivers/cxl/core/region.c     |   6 +
> >>  drivers/cxl/cxlmem.h          |   7 +
> >>  drivers/cxl/mem.c             |   5 +
> >>  include/cxl/features.h        |  16 ++
> >>  8 files changed, 510 insertions(+)
> >>  create mode 100644 drivers/cxl/core/memfeature.c diff --git
> >> a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst index
> >> f86645c7f0af..80e986c57885 100644
> >> --- a/Documentation/edac/scrub.rst
> >> +++ b/Documentation/edac/scrub.rst
[..]
> >
> >What is this content-free blob of cat and echo statements? Please write actual
> >documentation with theory of operation, clarification of assumptions, rationale
> >for defaults, guidance on changing defaults...
> 
> Jonathan already replied.

I disagree that any of that is useful to include without rationale, and
if the rationale is already somewhere else then delete the multiple
lines of showing how 'cat' and 'echo' work with sysfs.

[..]
> >> +	depends on CXL_MEM
> >
> >Similar comment, and this also goes away if all of this just moves into the new
> >cxl_features driver.
> 
> Agree with  Jonathan told in reply. These are RAS specific features for CXL memory devices and
> thus added in memfeature.c  

Apoligies for this comment, I had meant to delete it along with some
other commentary along this theme after thinking it through.

I am now advocating that Dave drop his cxl_features driver altogether
and mirror your approach. I.e. EDAC is registered from existing CXL
drivers, and FWCTL can be registered against a cxl_memdev just like the
fw_upload ABI.

There was a concern that CXL needed a separate FWCTL driver in case
distributions wanted to have a policy against FWCTL, but given CXL
already has CONFIG_CXL_MEM_RAW_COMMANDS at compile-time and a wide array
of CXL bus devices, a cxl_features device is an awkward fit.

[..]
> >> +static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> >> +			    struct cxl_memdev_ps_params *params) {
> >> +	struct cxl_memdev *cxlmd;
> >> +	u16 min_scrub_cycle = 0;
> >> +	int i, ret;
> >> +
> >> +	if (cxl_ps_ctx->cxlr) {
> >> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> >> +		struct cxl_region_params *p = &cxlr->params;
> >> +
> >> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> >> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> >
> >It looks like this is called directly as a callback from EDAC. Where is the locking
> >that keeps cxl_ps_ctx->cxlr valid, or p->targets content stable?
> Jonathan already replied.

I could not find that comment? I *think* it's ok because when the region
is in the probe state changes will not be made to this list, but it
would be useful to at least have commentary to that effect. Protect
against someone copying this code in isolation and not consider the
context.

[..]
> >> +
> >> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct
> >> +cxl_region *cxlr)
> >
> >Please separate this into a memdev helper and a region helper. It is silly to have
> >two arguments to a function where one is expected to be NULL at all times, and
> >then have an if else statement inside that to effectively turn it back into 2 code
> >paths.
> >
> >If there is code to be shared amongst those, make *that* the shared helper.
> I added single function cxl_mem_ras_features_init() for both memdev and region based
> scrubbing to reduce code size as there were feedbacks try reduce code size.  

"Succint" and "concise" does not necessarily mean less lines. I would
greatly prefer a few more lines if it mines not outsourcing complexity
to the calling context. Readable code means I do not need to wonder
what:

   cxl_mem_ras_features_init(NULL, cxlr)

...means. I can just read devm_cxl_region_edac_register(cxlr), and know
exactly what is happening without needing to lose my train of thought to
go read what semantics cxl_mem_ras_features_init() is implementing.

Note that all the other _init() calls in drivers/cxl/ (outside of
module_init callbacks), are just purely init work, not object
registration. Please keep that local style.

> >> +{
> >> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> >> +	char cxl_dev_name[CXL_DEV_NAME_LEN];
> >> +	int num_ras_features = 0;
> >> +	u8 scrub_inst = 0;
> >> +	int rc;
> >> +
> >> +	rc = cxl_memdev_scrub_init(cxlmd, cxlr,
> >&ras_features[num_ras_features],
> >> +				   scrub_inst);
> >> +	if (rc < 0)
> >> +		return rc;
> >> +
> >> +	scrub_inst++;
> >> +	num_ras_features++;
> >> +
> >> +	if (cxlr)
> >> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> >> +			 "cxl_region%d", cxlr->id);
> >
> >Why not pass dev_name(&cxlr->dev) directly?
> Jonathan already replied. 

That was purely with the cxl_mem observation, cxlr can be passed
directly.

> >
> >> +	else
> >> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> >> +			 "%s_%s", "cxl", dev_name(&cxlmd->dev));
> >
> >Can a "cxl" directory be created so that the raw name can be used?

In fact we already do something similar for CONFIG_HMEM_REPORTING (i.e.
an "access%d" device to create a nameed directory of attributes) so it
is a question for Boris if he wants to tolerate a parent "cxl" device to
parent all CXL objects in EDAC.

> >
> >> +
> >> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
> >> +				 num_ras_features, ras_features);
> >
> >I'm so confused... a few lines down in this patch we have:
> >
> >    rc = cxl_mem_ras_features_init(NULL, cxlr);
> >
> >...so how can this call to edac_dev_register() unconditionally de-reference
> >@cxlmd?
> Thanks for spotting this. It is a bug, need to fix.


[..]
> >> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ras_features_init, "CXL");
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index b98b1ccffd1c..c2be70cd87f8 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -3449,6 +3449,12 @@ static int cxl_region_probe(struct device *dev)
> >>  					p->res->start, p->res->end, cxlr,
> >>  					is_system_ram) > 0)
> >>  			return 0;
> >> +
> >> +		rc = cxl_mem_ras_features_init(NULL, cxlr);
> >> +		if (rc)
> >> +			dev_warn(&cxlr->dev, "CXL RAS features init for
> >region_id=%d failed\n",
> >> +				 cxlr->id);
> >
> >There is more to RAS than EDAC memory scrub so this message is misleading. It
> >is also unnecessary because the driver continues to load and the admin, if they
> >care, will notice that the EDAC attributes are missing.
> This message was added for the debugging purpose in CXL driver. I will change to  dev_dbg().

...but also stop calling this functionality with the blanket term "RAS".
It is "EDAC scrub and repair extensions to all the other RAS
functionality the CXL subsystem handles directly", name it accordingly.

