Return-Path: <linux-edac+bounces-4001-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBFAC50A3
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D841BA0634
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584A15A858;
	Tue, 27 May 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmMVq1F4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1102AE99
	for <linux-edac@vger.kernel.org>; Tue, 27 May 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355390; cv=fail; b=kH4WYVr5GwZhOlhGbdbR4M8Id/hOkhgiMZwgqefrI+aveiCnpC8bOcJJacAdXCU7AoYVbClRn1fek4o01TFQK8IqHF/oF4cuirADGiTmKF3UpuR4J9QQ7Ngj7agNxWR6I9AJpCFyrGe4d9MneBNFkCmVXXf9KIBlqw6Wguxsh2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355390; c=relaxed/simple;
	bh=PR78TmOccFAjfyCUOM7lk/41+WXSlDyQbFPEp8RisuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1ktDnq6CpPcW80vTQVdrQxfouYhBDHtDDrqTd6JmbcgLJW4ta2W1ZIXdlqWwoaoA7p+eEew3yzin8tk/aIXcPUmJuuLKJFtWhudUaK/J9sTJKnyvIPIZey2KE13PvI4yyTVqyTBjd4DWmFi5C/YDOXrDlGPry1KXwk8Dluo7QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmMVq1F4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748355389; x=1779891389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PR78TmOccFAjfyCUOM7lk/41+WXSlDyQbFPEp8RisuM=;
  b=gmMVq1F4M4SYm2fAWplI/R3wQ29QhqbmrAjinBFLG7mbT/PFASzE3Ckq
   Zef7tAp3ijX62yLtKWIXD7owvs58WQpkaXVzb42GoXskdefOtiQa/GAfO
   OI+8EO5Y9c3BFOlkH7AnXdIW+oke8ISDWs8p2WlisfX+Gk0l21cygVsaT
   ejmGdu+EJ8LMuHNM7mr39WbQdKQLjVM9XyQWbecDTtSmYQuwJeKuIzUjc
   laQTfT8DcRwOhxduY9PgVjAsek6e+LB3ndEOSph5GHG0l3PG5w+BPBRrq
   rpQfCZpetLIVHhVW6PA6aMdKisPhENeeO14d4tORAVdHR3PXtZCXh/VCg
   g==;
X-CSE-ConnectionGUID: sYECZmxtQzmw0+xbqnyN0Q==
X-CSE-MsgGUID: bbk/moNzQxyCeL3DE2bmLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50402244"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="50402244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 07:16:29 -0700
X-CSE-ConnectionGUID: NBbJWK+WSOGPbaRTJPyj5A==
X-CSE-MsgGUID: YCWtXdw7R/yVF8oJUnXirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="148103016"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 07:16:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 07:16:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 07:16:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.51)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 07:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THb31l9cTviJNFGQDzX7P0jl/k4x0R1GYoJDy0vne9NWq4fo4MLMPBL+G7qE728vI5tIpDxZrMwrM2rs1sTQl/vGhbocOcele2/8CrtDKnhPonLMYqVmu5FWGnw04DVq90alrF2E2wxjBceA1+2PpBhRgFchw6xPIMCxJA5aWbLLUlXTIQgAH3CzxlLJaaCZbg9Cp80ihz2YCGKCuhrJ4X1mx0keIjqt2wNEvHGynsB/sQwPM9uM4O2CVwmkzeQtNTdbtyOGp6UdoWkLD3+LPBNaUw/hvxrKLNFVzwkmeYDRJdaUv5bbm8Go6V4Uin35BdBKzEEoMRqVUkI9jaXVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zyFnYUIJV7VsQ22TdCD1sk7/+t31pojnQaVXqu4caA=;
 b=LN9dqI3nQ0sCEKPAwPfH5EdY3rnzo0qCV5KONWugWPOOQJKtE14X89Gnaz9qefbQL0+F1/a05mwYWht0oqIozj5gS5s0iftIT0TMgp4utp5im/3G+bAYXdFZAjBsRV82vFAHc4Nr80g+zjMOL3ZU+Ww4j7FTXP0kHp55/7vTcFBfJ5sVDmKUBsfO7Qkp0iI3HrEYeXAGeNc9gzcSFGuZ43kX/pb/xWRiUgCI9ozPUuM+gLQLXcdZCoAVlucUvRnJ+oH/bPYU4zS21rLlgT87qD0PkgniJvBtrUdvz74lzADW3aMMobHD6yFcq/4PvtnxBG6giceB4Bveu2bh3yYY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 14:16:08 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 14:16:08 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"hunter.he@jaguarmicro.com" <hunter.he@jaguarmicro.com>
Subject: RE: [PATCH mce-test] run_hard.sh: Correct test name printed to match
 actual execution.
Thread-Topic: [PATCH mce-test] run_hard.sh: Correct test name printed to match
 actual execution.
Thread-Index: AQHbzurZQDYHyI1uQkWs43S+7XiGELPmgSgQ
Date: Tue, 27 May 2025 14:16:08 +0000
Message-ID: <CY8PR11MB71342CC625C146A36D754F358964A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250527093448.157-1-rex.nie@jaguarmicro.com>
In-Reply-To: <20250527093448.157-1-rex.nie@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB6623:EE_
x-ms-office365-filtering-correlation-id: 33e57884-0b14-4026-523d-08dd9d290691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HGFU8wioXbxZZo6hyaH0vJqxJY/yEh1z/F8IrrLfRlqlMyo3NmF8chXxnlz4?=
 =?us-ascii?Q?uNhdvnQv+3Ba8wLIY0WtIAAAUU4E7Nu/UCg1i64QwtTrNFzFJW24/qyOqEP5?=
 =?us-ascii?Q?z5r/r8NyvcWgioFC6Vr06iH9HMSDPFOlzB7V/G6TMGncsdZM/jmacc6wIWle?=
 =?us-ascii?Q?n8Cm++5vEiMWGRoR3vrZVoq5mPegW472nG6chLSbxqNHgH3i6Fr5tv5a8j7d?=
 =?us-ascii?Q?olslgKOIIekWX5jxsqsmFdO+RfQBWztWJEyjX7zbzYuz+/ioNSDPJizBqPhs?=
 =?us-ascii?Q?h7c6rMahkcf/nBeCqJrSkCZ/3G+0p+tnmkoWuK0PIuGeBwnCMMA9mAqKIpu/?=
 =?us-ascii?Q?Uc3BbnGHgwJ0Lb/mTZUpOXS8e/PYFtqZ86PBWq1MHTQBSsIgpFXwBXoXHun/?=
 =?us-ascii?Q?x/E2Lie3PFf5rsDZ/KzUNKhaUN8VTIIT2kfH1VsInLDHjbeqg6wkT3CG+UfL?=
 =?us-ascii?Q?ptjKtewb3heQLnIa1kJiqW09eQiKyPMDj9QH4/doxtqYMhzwWC2YWIOIk8ZG?=
 =?us-ascii?Q?qXYYXCMPNgDygOH3hnyClM0qotefOrQk+ArejszLp34j8+YxhJSm5yNqK+Ui?=
 =?us-ascii?Q?cIBdqQg6Ii7+NPWunN9qD/nbDJUu7WT3NkBUzUsTL4LjX5j5U8DDmDhq62cj?=
 =?us-ascii?Q?LoJw4pG7EYNAsrlqG2fQPlhRaGH3ZQtxN3kE8yx3do4TI+uy6FQkwH2w7Ffz?=
 =?us-ascii?Q?B0YQb0Pw69crVmzMxB2vtYWgPNkubpHnbP34Jqtke0oGk+6bS4c7WZKOJypW?=
 =?us-ascii?Q?u6xEg5p3Wc3Mi1va3iTxRoUXUznpDNf0d0MB5/EJmOvEseN9pJXtxa7ea62W?=
 =?us-ascii?Q?DO0KPnX24d4L03aSq/MRiac86k95w7I5Y3H8+XojtUfdc4N0Y6Bq3btKJoMt?=
 =?us-ascii?Q?8tL9IjPwmC7Ss7KKa/WYUTLJF1y9jZZXR+oQ62VXqyNInuyvfck8sLxYYPTa?=
 =?us-ascii?Q?f0yxG0b5PyMHz8OToxjA084eyM28ABqwReTMVZHQGLdJnHQG0AJ5CS8iGN9t?=
 =?us-ascii?Q?Zo3UYkmDB3QzHTu+yi/FsmkBqoP2+ak/9MdQg98KkLfPC+DHa8VanvYIcod5?=
 =?us-ascii?Q?+DEaN+yDNNYu1rB0VIdILMUG41Gc4q019nCUlb+VueOVFf8Cjb4OMKDjddnC?=
 =?us-ascii?Q?GFANwlJIplK7WhesR7z+W80WjkiDIv4SuqlXuvZfq6+uULntSMBHgy7rP5JE?=
 =?us-ascii?Q?iyNb6MkHzckq7smrb+pkEhbU8YJAFLswRiOw9EJyBOxsGNLQ5GhzCJWvI5Xu?=
 =?us-ascii?Q?D0tMeYIKX2G8A/CUcOAvyBSNLJT7adL/h0kncjMnqImzatB6sSCoj52Cua4E?=
 =?us-ascii?Q?J9D3ZFy3QSOf/+tdobwdM6rS3pf3LXrDveLxMN7GEzT6MSFdTtd+1stlCB99?=
 =?us-ascii?Q?2g8B+lJw4Us9blQfLY2V+s2aBG1+wyNmcurCBET9Uzqiwifzyw3eOkaHnTVT?=
 =?us-ascii?Q?fGgytVu/VliBxdvbfIzIU+9iEnIeZokNOLzc2g5tvv1dtxKudiwSbQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Exe35soKw3c4K68j1DCIo334pJt9+gMnP4n3s1A7sqsTu4xAT4icvvcHF9N0?=
 =?us-ascii?Q?Gw82Cy091s3krDYkol7D32voWO4kcADNfWDGTz2SHLsUKqKgoJdqwzoZVXGx?=
 =?us-ascii?Q?QBCoCemtCaJbUFZCCdqctU4CHd8FYWgvonAhexJznfY9nVMScqNSBCAMw1SM?=
 =?us-ascii?Q?CuLRoq1dq403O7zD/qzsIVeVKaT8Fg3zO8TmfGw/liWYmbG9t9tAAz2N/O8D?=
 =?us-ascii?Q?gyn8sMv/tHN3sjqPb9JoY/CvUUQ80gU+IDvUC8+QQRFZR7SmUJc1s8NmeWrd?=
 =?us-ascii?Q?2ex/nuOEL5wWbaH8JKwFBHhE0c0zPIuOgTkdXjZB+JA6EcJ6q0IMmcyFgGco?=
 =?us-ascii?Q?q3UyAg5j+xtVgkSx4YOGDv3brN8tZU7S1kIgxs+MMqT/iT9rOgOPIgBoFxzJ?=
 =?us-ascii?Q?dNqRcnJlXKtMzH5VQq3TAn7psN9dUQ3MnnomxAv7FEDG6Hlwglve1lymT5TQ?=
 =?us-ascii?Q?tZpC9Jci7LrG2/Dv1WT7L6KIVxe91/MgQ9reFYo6oXg0siIUZ2+4VoDrzuSX?=
 =?us-ascii?Q?HcS3dYm9rhdFdxRRDbr6GWaxYKUT++OCXP0eodAWRV0JOCT1eW98Hu3UJq7Y?=
 =?us-ascii?Q?Nbwdjvpm2RUJuJaECg3lm/qKX0DxF6sDclZIIgMMsLmqdC/zmOA9pmL7vQaS?=
 =?us-ascii?Q?hdml7lw2cZRE2/w8J3QiGyqkrl4fx4BExijpVb+eoosmfNt7wKhJRY87Hr8U?=
 =?us-ascii?Q?tqQYiWIyD8AlZG76qFOXCSTxj/uUfH5mmbBkTEervKz140kdubqNPs1I6fwp?=
 =?us-ascii?Q?fKUSeUM0l6hJFn/v3cgxTrl6ML6B6rqbK9+cY6diB44+9AlzSzOjy9k3ckv1?=
 =?us-ascii?Q?j/tBbBjvDzZzsLS5dGA8sBUrGv73k9hwP4z2GnxQKHxFoIDnAjudnfqGEh0h?=
 =?us-ascii?Q?HOWPv5PX0hNftvlsE6VbPlpicWKqk5HaUCludmzlX+EjpqyBiTRQwnMmCPYv?=
 =?us-ascii?Q?4on44Vdi+lqu/gPWMYRTcG+xdp6Glw2JUzOKhE1qSJANJeD9u9Wlz242dPL9?=
 =?us-ascii?Q?G/P82DAKlPF3MtU1VLum9kfW+c6lWl/jrtv8mkwueL/TSiPszQagIUmbYYNd?=
 =?us-ascii?Q?qQi//HKWALqjh7WCFhc7WHALQE6TV5pIY23+RiciJr6FS64TVorBkTpzSUk1?=
 =?us-ascii?Q?9joUEHEQ31cFNBxrJx7u3Stm27fgkSPtdThqNlN5rONR4HrmYL/dnuV8n+sD?=
 =?us-ascii?Q?ffJ90PcCBNGCEAwVgzOg4ckCvV9H859ubbD+K1qubibVhQr0IBSm9tEnxC20?=
 =?us-ascii?Q?W84eSkYWEHdEGfnPQHecZfCQ6+5TkDxvgk/CA+MvcuUV/TZDEUFPd4R+LYFU?=
 =?us-ascii?Q?UEe6Iwtlsl2ryWcI1H1q0MJSZVq5xtLSViT43SFOU2AeQtQ0/Mh3BbjdXben?=
 =?us-ascii?Q?9P1dEB1U/LWgTpKier0DSv35TSqwIC56YPOZKY3kUhoDNZ+V2NGmIj9J++Hv?=
 =?us-ascii?Q?7wF/S1UkPxGeDO4HtaS74RJ1AIpF/4RnxUgQ8eyVbDr3DuKDBj8XRYTDmW1N?=
 =?us-ascii?Q?DBGmj3HnmqJWRGSAFzEaI98+Qq+V6Z4V3jV04WxOoHv5c/6rJPrMCjkL2qlu?=
 =?us-ascii?Q?Wq8+Wt900x/2M9E/UA9ArSFCt4rcmu7O6e/0EphZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e57884-0b14-4026-523d-08dd9d290691
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 14:16:08.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPDjtqXMZ3ZRqW5TIV5uJpUIqo/repHxEVRkOZLCvbrnrvTFyuorqsB6wEZq1y8EjjfXx+EKGrlhozQbD/ujZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com

> From: Rex Nie <rex.nie@jaguarmicro.com>
> Sent: Tuesday, May 27, 2025 5:35 PM
> To: linux-edac@vger.kernel.org; ak@linux.intel.com; Luck, Tony
> <tony.luck@intel.com>
> Cc: angus.chen@jaguarmicro.com; hunter.he@jaguarmicro.com; Rex Nie
> <rex.nie@jaguarmicro.com>
> Subject: [PATCH mce-test] run_hard.sh: Correct test name printed to match
> actual execution.
>=20
> In run_hard.sh, "run_test ./tkillpoison" is executed, but "Running tsimpl=
einj"
> is echoed. This patch corrects the discrepancy.
>=20
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>

LGTM.

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

