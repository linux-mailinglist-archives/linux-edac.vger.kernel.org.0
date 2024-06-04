Return-Path: <linux-edac+bounces-1175-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C38FA6F7
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 02:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5A1F23EAC
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13742119;
	Tue,  4 Jun 2024 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZieY48IF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19C65F
	for <linux-edac@vger.kernel.org>; Tue,  4 Jun 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460797; cv=fail; b=k3m3uY8nv9LcfQdmp1EX2R5ZhUS9Hk0hvwTHs0MEGtbqwW7TkxfsZ8HZU0Y1d8b/d8atjih7vCBMuPLS806bvYTg2g1mdC9qS/Th+RnKBFQjzOHY4lYH7Qn8VLVoKP3RvJsLbZ68Ls9i02RgrDfdtH4xwEh+3Cgqoor+U4GUXd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460797; c=relaxed/simple;
	bh=+GG/vZ/VF5lXFdZMUoQeAJoyndiP58QC8Yd0nEMD2ic=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tIGhNgbRsqCHcnG+5TKThNIPkMv1i5pID0W0MRLvVUBi6q/Fqm2M0bVhvDkZrc7CkPCoLAXvzErC2pgRc0U19UWVgHzqtrnkP7rjdhSFMmcJIiAJN7efcpef8RS2KDuNOkuSr/dPWesby+0y4eqxKHXTGVZVlmhtck9kmRpnXvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZieY48IF; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717460796; x=1748996796;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=+GG/vZ/VF5lXFdZMUoQeAJoyndiP58QC8Yd0nEMD2ic=;
  b=ZieY48IF4VjpnMxXoFMif1dMCxCsH6WlLBV3JIuvN3G33YuKKLz2n4Eq
   tddGGm1vuAIXhV7UN0O+GzT3yiLsO7Dk4BFFCCMNLWzeMYxpzitM+/Dof
   crX0ZBfGOsHJPWkdB5nRf4UuEVkp3S8Sbe4bf3izDt7tHW2HrfOaoNTg3
   3Hh8jz7uJc1I/c2b9Q0S5P1rdQUuHE1/uFUXbGUcjuCyn1xUG17Ha/+XU
   5HUhBO/vUz/QFG7f2M694YsbcHRnj0WyTSHYTnYH+m3on8S7fnJWYUUZ+
   2aj3pOYMIaVWBLV9M0B34Kh7FfjeSq9yriKv03XICshsvtaE9c1yOPz6j
   Q==;
X-CSE-ConnectionGUID: k7MDUtmRQJC0kVw50mD3vg==
X-CSE-MsgGUID: 96JkUO2cRYKVzlVnKJnN5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25379343"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25379343"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 17:26:36 -0700
X-CSE-ConnectionGUID: dAs3kKhUTKqoLVIi12h2Ng==
X-CSE-MsgGUID: RwhWHolOSOijm1dT+iCgAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37164530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 17:26:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 17:26:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 17:26:35 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 17:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD2JKnOC0nZgYOJpQRBtI2F9CWId2SOMavPX1j5ZPN9Yowpf5XtaIgEUC4g2jXbUFbfSUJHWjDwnyo3ZpRdp0M0YgNmdt17LNDEwZUEHVcFSrdN36QxUYNGgM6lh8XRmZIQ4FtEJmrW57fm6WfNLarhbOohB4S+3RGR55/6rmyx/YQIV1gh1znlVIWU3aXx6P+BDrhpqCiFrpoA9o9jLPQQHY6gF6Q5WibBYwtLv527BWC3NbcHi5NrprV+rHo3bwUOcL2o13c6IqtHfrP9Pd+s76XznHvrqU1A3Rq7eEDM6zoDRz/wxIQA4wuE2V4Npw7wpw0qspIb8wzepZUy3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPNz6fXCYWL1iLv97pPIGD8g/R35fVFlpEyf2XM/m2g=;
 b=hD/rPa63Zv0t+7NE5JfC7B/15C6zEbnD+QTYpc/qDsKBcFlqjrbYB9oYBumY6oATLYMwc7lvcEKY6S8QCbjxrihbcP8nYdObGPt8qiVYoCDNIweEqp7QKNcTvIpd9TGIaNYb8Oul6lCNB8As71rszADE2Qk76N7i9XlKUq1c/zyuxGmdRSE6YsmskQ2SvgZ8hiEeioz0rzpvtLNyUVMxROOAlT5RnEA2bfwRMR+meO8dg6nrhBWZp92TSwGRh7g3jF/jTr7jwNpn0128VDuF5dzAz6VMv2z7wHAOebmxLuNv2cj/fea45YvzjlTDzol2UmYfUcca2VwSTFXGZy8rYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 00:26:33 +0000
Received: from LV3PR11MB8765.namprd11.prod.outlook.com
 ([fe80::194:a2e6:603c:7e3d]) by LV3PR11MB8765.namprd11.prod.outlook.com
 ([fe80::194:a2e6:603c:7e3d%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 00:26:30 +0000
From: "Esquivel, Jesus" <jesus.esquivel@intel.com>
To: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "mchehab@kernel.org" <mchehab@kernel.org>
Subject: pull request to Add Corrected Internal Error for aer_cor_errors
Thread-Topic: pull request to Add Corrected Internal Error for aer_cor_errors
Thread-Index: Adq2Fbben3R5QuY/T7OPIdwUf7fHMA==
Date: Tue, 4 Jun 2024 00:26:30 +0000
Message-ID: <LV3PR11MB8765A783524441D304203FD49FF82@LV3PR11MB8765.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8765:EE_|SA2PR11MB5036:EE_
x-ms-office365-filtering-correlation-id: 223b0024-8e31-4aed-0825-08dc842cfb4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1mLHNOv3XEb4mD1R+t9ASoqT7oeM2pVb7LQPmBJC56Wg4tTJMnTzS7fFazMM?=
 =?us-ascii?Q?JI/DEQzWqhaYDC1zvQNOZzxyBDqNMk75T3a858snrBbP1uo3V8vX3aBeS4A5?=
 =?us-ascii?Q?NSdF0ySXwr5JUrvC5jYpTMA2Ce9mYdsPZtJGAOmMG2vv305M31Nf8fsZ76pW?=
 =?us-ascii?Q?DmtcafY1jpBIZ5sV5hdSYNnr21s6Sc7v48WkRLIvZZZJAoJBKMvxkSyNRO/N?=
 =?us-ascii?Q?x1hrZy3ntAOz2JcPzoGJtmfgEEoRZPPK1mMFWlwTRxxrYsbBi6PwyVbaA20q?=
 =?us-ascii?Q?UxxFQLNL6ihm6sWJ2a7UEWBBXSkTc4ufjDIQfIMRdrJrLizYQKDIF+sJHeMY?=
 =?us-ascii?Q?ZWireI0159abd9/iGjn6WLdVo+5ALhYdEjFkOcrCoNdRAxRw0rLFz0RPo2+d?=
 =?us-ascii?Q?u7ReiH4rnTU438sFhjij3W2Uwfrmoyz+lc2JsDLUzM0j72tpn7nkluDjTcQJ?=
 =?us-ascii?Q?yKzoz7HnPCtnI7mGZ/RMSfBDz6H2rji4DfxDmGTj1pMZdKsDvKElzU3JHOlK?=
 =?us-ascii?Q?vFMacZSXgWXnncSwPIxM8AA7sAmERmlor248TRpJ3wMrnBhRzMdgY9NhNsIh?=
 =?us-ascii?Q?x8YtAgatj0Flnc6GpFFo3IKvikw0aBvkw+2RsYLSoLHH0ewh3Y1GmBAL593o?=
 =?us-ascii?Q?nxNVzrukwhNAMTiK1O5UZdgJHIF9x03nXBomw/cDhhuDp3WYv9LY0DPHMSSs?=
 =?us-ascii?Q?YZ0NFu+PJsOV/Yf4nmJ4T1Dsj6DW9hCG1kI5IoNHUY9MLaYLfIADIw44ySRg?=
 =?us-ascii?Q?VzpPKbk7Pw/2k/0QeBnwKiOx3Y+MqqXpJeKkL5SY2u2xTCL170Vbki9TGqfj?=
 =?us-ascii?Q?2cfEnF/zroDPVBhax0gP013r+KJmtN+zjfZUzRSqj2f3lgJNVwHOqmhFVKsE?=
 =?us-ascii?Q?9OZbxR4wen6OcQ9hD/92tIn7cKhrh4xWesS0vgQgjuKPTvwUSoLN8g8DPlQU?=
 =?us-ascii?Q?EQiQ+N0NZDS7kSsZoYdiMaG6ngAxJelGWck3n8aKz0Rh4V+o5IOjSs2Z/bvz?=
 =?us-ascii?Q?pqymYn4Bt9YBnNm+zvhCCwf0BWnH1TnfGrMelyHcijeZ7tu+VrvHtdSSww/Y?=
 =?us-ascii?Q?aZbVtcOeWru8eQ4qlALijnk+v93w27jgu5K9NK7KGKdw5Mj4HkLC/rXTqW/O?=
 =?us-ascii?Q?Gid2WO5ffnbBKlz2d6oV+txqDv54vAHXtxg6hRhpswywKxNv1ODsBRT5iKdx?=
 =?us-ascii?Q?6P0/+aFDDCf4VvAmHvq0fxy2DKaNIQ01qvfol02lr53EE8Fgig8Gm0ellVES?=
 =?us-ascii?Q?Qp9Em1JWCWAHnpwCI4Si3pGIxHj2LEcXDZCjsSJK+Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmjjbFrRbRv+Reio+u6+JfpRZbABToRBsp2h2MVu3XdmukmRm0EFr7Cn45vV?=
 =?us-ascii?Q?S7CIab9UVqoMUlyuHT2kahdxS2VnpEuiIyYvggNy3jSp4gLbOdHkZ/eIxqu2?=
 =?us-ascii?Q?AuO3trdYnKNmGO+W33UNlY+lUprgDXWyh3Ec0kpRZW1mamCPXIL3yFiVg4Gy?=
 =?us-ascii?Q?ExJ+YWuhw5Sg5kwhpKTD6L/tKcxW3G3oiUlXQhGh/jt8zOFmcKpv0RXO7I3x?=
 =?us-ascii?Q?OBUKO+1Vzawd4c+YUIATazlrHwLLYkSBqPjnflYoptMrM4kxgaaQDDRMiqhE?=
 =?us-ascii?Q?4dkeUJPsXOFaEPf9x4fM4dVOo7+10w3Kovc87DqNKNNmNeG8c9M6fdHpN3jV?=
 =?us-ascii?Q?GJ1ICKU1H5U8ZnYwkgnP6W6qHVUo8rApafRgsBVDzB4WyeOIVjiFty3i1dh9?=
 =?us-ascii?Q?5QZyEpLKX+aN0Wd/i0OAzwgQSMBGqXzI2+2vEHRrdKFhSJl8ddEDiNOTSqFF?=
 =?us-ascii?Q?WJVaEU66KHjW2oTzhGUamL+ZyajN7ENX5QMPzWX2mBrCZ1wvQe2NotY4b/oA?=
 =?us-ascii?Q?zkEwPTCHWtw+xXgczB6foP5VjVK0D4cwZk5GjlfTfj8oLI5igu8QyCdJ4Cdy?=
 =?us-ascii?Q?aEIrOPasLO5zBq2y9mMxeeI8H8T7ElJD/k2BSFo/OYGxcNxt0y/K8vsgVg3Z?=
 =?us-ascii?Q?/vCKomBziECu7yZ+od7Q4He74w+ZcsEm33xF1CwQbz8N0ltmILisG+EOBWx4?=
 =?us-ascii?Q?TfqlDIPkuB2jAUKFuOXSU7RiluZjAo0nPY6oY55o4M8rkq4rrL8cAVB0UnkX?=
 =?us-ascii?Q?4fU779wlcqJi5zOnC5Zg42RPjPOxbiEhVgBeP1ALq70VmRwW0ZQoQJly8DJG?=
 =?us-ascii?Q?0wC8hGQq8Xln9PRiYEQ3zTAMbJLNgMtOe1kvE1b8Viz7bW/aSU6iWWesE5pz?=
 =?us-ascii?Q?mnH5b+a7ZNLNxdOs2Ouxpra3u9CyrZVf3PUVXaWb2GFw1TbryQJ3PtNoO3vW?=
 =?us-ascii?Q?Ws71n+5t0K8eJPZFU8O+Was1zW9ltOW2lF09ZsU4tvk8RRSC9erYgU9Dh0SH?=
 =?us-ascii?Q?B8JvV5cZMKxur71jFJjnrYsk+frtwJEAUwduB/inOMQUnOq3DyXArtRZKUtC?=
 =?us-ascii?Q?SNVWZzH1RQ4smIBR72261s9jqRK+X+Y4fwQQdjlRh6DCcsLEW9ZOiewNA3K6?=
 =?us-ascii?Q?WHf2dcPtcNwKHouv4RMev1SpNsPZOcjdF5hqoLFH5x6cE6pdjVJNGEA4+tBu?=
 =?us-ascii?Q?oQEbTk5RJ30fBcPEKk1RPPmk4OjlmJtKE924hiiHY14CiUTDnif+4Ay7XV19?=
 =?us-ascii?Q?nWe3QnXEhJRVeqiaap/11afroTJny+HAFlqI9jT+n1Be12jCwXvgRE0yusys?=
 =?us-ascii?Q?jk4vji/yaTgAi0Lyy19BFS3PUgVaS/d+YzLOGIy0qe6TEI9I/JmrpMR6HDKF?=
 =?us-ascii?Q?t4YnkSM88UVfLEcSSWXaQUz+m5zmHpUshqk4f2hD6e5+GFSHmcsBuMlHnaid?=
 =?us-ascii?Q?Vlbqdlfi+6nxapIJQfH/ioK57fYOUjcPlLIH3qjeFNpDqSdCT8cOrQAP7Md+?=
 =?us-ascii?Q?N8xO/Epng+c8TJwocpXIeiL1NXNmxCr3rsLAVvK3dSUupKuHsh9Yf7F7uAVp?=
 =?us-ascii?Q?bF7umWhsst86kCPZZ8Iriyd1yiI5ZWFcd1EEUsCV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8765.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223b0024-8e31-4aed-0825-08dc842cfb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 00:26:30.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXnhAGHnaNNH8cDfYKXkrzTb8ewB9tSLRAQfhu8nqLf7mSfsrBpJSYc6wmfyEQAbkXYFa63FrwAkw5Sb16mhtkFCx6q4M4P9DiIFcoGf2c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com


Link:  https://github.com/mchehab/rasdaemon/pull/164
Description: Add "Corrected Internal Error" for aer_cor_errors to decode th=
e error reported in status register in bit 14.

Jesus esquivel's Certificate of Origin 1.1
=20
            By making a contribution to this project, I certify that:
=20
            (a) The contribution was created in whole or in part by me and =
I
               have the right to submit it under the open source license
               indicated in the file; or
=20
            (b) The contribution is based upon previous work that, to the b=
est
               of my knowledge, is covered under an appropriate open source
               license and I have the right under that license to submit th=
at
               work with modifications, whether created in whole or in part
               by me, under the same open source license (unless I am
               permitted to submit under a different license), as indicated
               in the file; or
=20
            (c) The contribution was provided directly to me by some other
               person who certified (a), (b) or (c) and I have not modified
               it.
=20
            (d) I understand and agree that this project and the contributi=
on
               are public and that a record of the contribution (including =
all
               personal information I submit with it, including my sign-off=
) is
               maintained indefinitely and may be redistributed consistent =
with
               this project or the open source license(s) involved.
=20
=20
           Signed-off-by: jesus alberto Esquivel perez jesus.esquivel@intel=
.com

