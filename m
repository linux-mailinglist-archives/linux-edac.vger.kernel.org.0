Return-Path: <linux-edac+bounces-5074-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D55BE4EC8
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 19:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57CDA358478
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8122173D;
	Thu, 16 Oct 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GkzniORS"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBC3346A2;
	Thu, 16 Oct 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637258; cv=fail; b=HLKaIsScfUFx/3RchEawry9Ph7G0pufLFRD4JtqyiYOwxzEG3TIVHbmly9HBMY8Oo+XoB+BMkhmmm5lXZpJ3fTqT9IxfrpRO/F/GbD3cI0FElD5O39oohiUeNI0XM0TyWd/mWKYCN26QhS8iXBme3EkCtpSTE0nzCLTPAmZxHnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637258; c=relaxed/simple;
	bh=jRgDOU+xPTRf2JZyhPyJVRMGacK9+g96nx/As7acrCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hpD4GEfpVSoD7UTFGJBg5GitzkwGQ3IaPG53e7YZaWjYxUx8zcIK4rOpIMHQn8gU5uG/InC7ZuvdA/ZW83DjzjdBi4MsB+R7P2SMnJnZDVBmY/MUu+IJ+b4utlSrvQAORq7TmQAXzOGSsaLNviO0uy+q/uZkFQSIa0mv1U8gdtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GkzniORS; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHRUJKdpfPO58Y+xzRXDgLkMd6KUwnBCZ55SzS8RIbEhwqQ7LLdgfWPl/a2/AM3lxr6w5w/XO0/6gnsWbcfHAUNFgZm0J7eA1xrudUZF4sWfMkahUaqLMUxGt5FzSGfGhw2caqSfNm8IdRnEaHSV/djaRzYm8NitEXCBFA2YpRcVZrtY9tsxQdQggU0xdBst/GhtFYb/975cJGXkxSL0Fh1yYDaUDDt0w+aKKhqUpnrRJnvHQfn41wf29esJBVtJZvYCM7ruVSi1mQ4C4knQI5wD8WlV64SoSGU4fMdqtkjJH1LiwGIKdkCh2Pud8S5wFvT5TQi/S2n1bnvGJrbS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41bxc+TlXuRvC8+yq3PDQVbrcaVXIhj83cbwXNdjMS0=;
 b=iSkYqki/PH6kLy4BH+1i4mGPgn/B8HkLeWLHxpe+/kUalHwwbyjCi9BchHEaiT36q1K4S8tQbEBufgGIHzpIv5VpEoXu6RFry0CrL5inoAVJo1Ten50mYRZFCd2+4cXu9tlYcVSB/9EJJcOwQNz+u7ME8WrJPk54MiHV57ET3HBikS52a9N4vIaVohE2ewN752M6gkDiWeSmrM4YLJxVVwDpkxHCDgMiES0MfnKZKTI0eyvQ8fpSqeG5aPkBc8IAZOZL5E6ZHyLpNsgHx2tLffR9Q6n2DoWXWUkXx5CinBjJLyRDRhvsRs/ZkYXWfKe9OkEqMQdrShX+q8/o0yH1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41bxc+TlXuRvC8+yq3PDQVbrcaVXIhj83cbwXNdjMS0=;
 b=GkzniORS/qsM4SZIgcXF6hHjyjk40oCqKV7F9Ez4IVTmFbkYw1P1xNzjrspN9+lrQQJGTx9ZKtMO/1mTY19q5mMVLshtGl9XM4sQnKPKmwrYa6qZ53jHx1KtUB+6Eb7NjFyD3aDDYdtgX5Sr8zm8LHBIo24qhT0VOVYlTtEnZw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 16 Oct 2025 17:54:14 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 17:54:14 +0000
Date: Thu, 16 Oct 2025 13:54:09 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>,
	John Allen <john.allen@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/3] RAS/AMD/ATL: Require PRM support for future systems
Message-ID: <20251016175409.GA806407@yaz-khff2.amd.com>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-2-4a62967fb2b0@amd.com>
 <20251016161037.GEaPEY_V0fbmPvspMa@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016161037.GEaPEY_V0fbmPvspMa@fat_crate.local>
X-ClientProxiedBy: BN0PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:408:e9::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: a34b3aae-d6d3-47c9-44de-08de0cdd0463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pyb4zBsTLbcUmWGAWBB0NvIKmWv7fRtjqMCTRaj68149y4XfUyu6Vw8NNIZF?=
 =?us-ascii?Q?224zaWuLBG7PWHm+uicSSnzsDFitjTS2Lgty0ipQbYidiV4Pab+ym3laWUy6?=
 =?us-ascii?Q?Y+MUY7e9KM4cFUXQ0WkO6J1x6ZNYhLxof1ZWpzOlblUzan+ONCOw7GtthbYT?=
 =?us-ascii?Q?XWO1yJ0yWwWV0iZXqWPNj4l62EtgPeK2wV2Tm/b9oVB1pST5VNM7icFnUhzf?=
 =?us-ascii?Q?iJAHp+bYfmfsfBttQeJSepGugv55//TO7Cwz/AEwVN02deN7fuMkBzry4cTX?=
 =?us-ascii?Q?jGr18KG2/nxvliIL855Vbru+w8YH7gwpvrgLcvgFUKsC9yFNJJw9iw9xpp7E?=
 =?us-ascii?Q?zyc+kYM1LlZUso/SJ3lYKaqu0f7Rgkj4zPYOfOr5WOnA+IP2GyxslLmNpeT6?=
 =?us-ascii?Q?UPgLtrOGei46/32o0uRngHAtc2g147jVZ+5ovFdzKT+hUNpRcWRyrW+UeBfF?=
 =?us-ascii?Q?1r6bYHNSRtvn9uHBZRXCO/l5JbFRDcdfFmDsTe5wG6tudoyhbOSgFj3XGTSA?=
 =?us-ascii?Q?e/oLakHk/2qoMOhmBSQjj81cZQ/3prp5/e4C7qsp8PP/0bxY27rrxMLHjYuR?=
 =?us-ascii?Q?aF28vNTbCZEyR3icJKCyhU1c8MrlSStUd4NwEP2Rj8VBTYIvm7coUk0gYm2F?=
 =?us-ascii?Q?WMfS0y0tp2RrwDQO9bw0eXqgmLeZ53CkDOrjS8oTMXVVwEuMFdkvDW6LebdF?=
 =?us-ascii?Q?2xT0Xy31EPHyZeXeRqQqLGFRAWQ0jU6JMgLa90sOmlwa4xB7pH5B62FGiB8/?=
 =?us-ascii?Q?L3vlEOVAJeT/yDL0N2XY+tZ81VKoU2Svwrm+JzpHYoFHbfw6oXxhwbJyBywl?=
 =?us-ascii?Q?39xjM/qPBxNzTfkABLJGPRLyaV603RrgPL++hw3+UksAvYS45itkCAlTKpay?=
 =?us-ascii?Q?IdTCjpfnQ2qBBVSedGRhPTwhMsPdjKCVNjXS+jskLY5PEPEIc1hCLHbUwfVN?=
 =?us-ascii?Q?MLkRHDdUhuS2hREv2RYCBthdETI162B9Et73cdsZYQY4fwDRKZMX/UtUz7K9?=
 =?us-ascii?Q?jBY2zTdWyQSmduU10N6hfUO89lkO27A4+7Xu9LvQkdt5XPceZmzlc69fba8k?=
 =?us-ascii?Q?YVaP1IRJ29USJyLrJkM1e2G1ZfP69yP12/tesbLCwrIBJv3fXsl0lT7Xplc7?=
 =?us-ascii?Q?3bQYwTRXfllgS39ffWs9L3IqCbsSuZTV9lJABOkI+tB4dIcabJ+b8Tg4IveM?=
 =?us-ascii?Q?Om+5eN5SWkiJh+sEhEMvQQMJBuHBnABASwIIF3rtxVCQXY9RgL/f2TLCoKLr?=
 =?us-ascii?Q?Z/qA0FnCYVRFVYAluupZuY8CDWUK+TcIPBQ/48j28U7kQm6yX2wfYEVWmaF2?=
 =?us-ascii?Q?RJG4UUf+QdqTaYBtGqVox5nPzOpSFpmiCTV85/vCKeMFsWeOQ15qQoCnVdAu?=
 =?us-ascii?Q?gRS8hYsd1bDKXbwSVRRtMQpBd3Vyc0ED92wLUQgYJc3VBqql3nZRUSNFAex1?=
 =?us-ascii?Q?OhCGaFzi5u9FFF+k2tX7oQnPVvwujXT6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxLDTvHDPwHDh2F/16t+4Z0nc0gs6z8B5X+w8EJFGDUr+RKlHNP+0JKS1LNI?=
 =?us-ascii?Q?qsJjY1JJjv38YsHL29hi/oxyJh1vFXgEnCffjGOgx7KHRVLL6iLUUgmGlKbA?=
 =?us-ascii?Q?Nb2BWCZ0aeH7Bote+BOCy5GxRPzuADWOJz8jPTgUZiGPx7b4Ax7oIb4OnDE4?=
 =?us-ascii?Q?+myaCjGL8Rz569p2LGnwuH95fOXg97Q764jDsTHAylH1QWZdRA0R8FCm89Fx?=
 =?us-ascii?Q?engMf9nv+sBpSvRbw+PkY+3UoOKI0CPwEHuPMsoF98WaF2x9OYqn68hlXJR4?=
 =?us-ascii?Q?fCfZbWiQFd3sthuigyo3bjZniQZoeyu/m6HpSJjD3WUVok6/TRwgBADZzejD?=
 =?us-ascii?Q?I137cJHx1qFagGq9dVBCXdxD8aAH06PoPlV7tyH4bglhmJgo/foBJe87OcIW?=
 =?us-ascii?Q?kgDrSViT3/LOkK7aQi/EW6CKwSDlIVEj3LgE0yhB920R425Whm+YqmfYYZW0?=
 =?us-ascii?Q?MlpzDCcxwga6hKzNlCNtffWtGUERSurtNQ+54Ophlrs47oRTam9Zn2iqvGa+?=
 =?us-ascii?Q?aW+nyOmKJxczQ5HYjD0j56zq7VC5kig9r/6CgvcE8l4Sco6gmKmvIN97kbWD?=
 =?us-ascii?Q?Rje0Y9Qhv6iFGppyciAENt67epBA5AC4u3uVxBiz0HhfDC0eshLg8pA3i+We?=
 =?us-ascii?Q?hwr1Iqqjm6SxtaYGPAxnLThAihpIpMk05NE+KlsqC1v1TMWz4DwOxkLkFbB+?=
 =?us-ascii?Q?j+bR+/2/EhREev0vP6kMtqhEXHQ8LRoPmVpRQwtNn73qXW659JJRPNrlzdRD?=
 =?us-ascii?Q?UeKfejYrOOAKzIJB1HM+mj/YNQ0N3JtFETWw0kP9h/9SSVuIkQHDWji+99Zg?=
 =?us-ascii?Q?n9aWSl3YrL9p4TNZ29FM48eXbucc8p7LEDYhK/UZXW5xp4q4nEuIeot3VUvx?=
 =?us-ascii?Q?l88J6/UpKPWny+lgup9O4lWhWtzzmgwAJWTaOoti8DTw7RnKE+NKo7qa491R?=
 =?us-ascii?Q?3IxNeAMR3Pt4J5aHFVannneTiy+jTEenVEgtTIJ4Y3odx2jEXgxuL3WHHISj?=
 =?us-ascii?Q?x1ZjavQzcDtvZ+L3i0N971HjYt/NrIatRu0KqWAQX3s9mraZCMV4hMm5gogj?=
 =?us-ascii?Q?Q6zKkm5GircuZXFlGaOOK39qwDedIH9zyt3yeIL/3RqrEdfb8pzFr4l06n9z?=
 =?us-ascii?Q?9Ra8pRAwImSVS3EFCsy67HBiRiMJRtSK0IhIqbIFszHI1F/k3kmL6KkFt+vZ?=
 =?us-ascii?Q?uoWKLkmsSOmTrCn8wVplK4E5Da8AiN+OuQhuX/vjpIaCKemE4xJF610Yrx7w?=
 =?us-ascii?Q?+7EmCHVHTi+KzGTpMbvZMI/0FDHhRS3nZV3Rm2V7XIRY8lf0x4xCJaAcaEU/?=
 =?us-ascii?Q?7Yc9oJz8//CFx3gZ8vqBASiI5FFECYBmTC2B2GIJKRVl3fV8gnV1Qm2FY+u3?=
 =?us-ascii?Q?2oxN9UXVU/USTjdtkxNesUpwhTsUdOc3Xj04Z544gmErz90xqQ4VNRcScBSh?=
 =?us-ascii?Q?RItWLYLl4azf3hIlIeuRWq7CGOEdM3+8Ma20eSO7L72+9jNRVhBwIRyyEbpo?=
 =?us-ascii?Q?1o3j2BeLjtdXQ+mBj2R2ugIQUtP/lljhAyQAUrl1niWsKlFwT9kxieLcjA8B?=
 =?us-ascii?Q?cUdt7TGST/PNHh8mkScRSsDCIBepH+37RMlN81Ce?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34b3aae-d6d3-47c9-44de-08de0cdd0463
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 17:54:13.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvPVlUk5+86YhNaUTfpoFt3b7paQOc3XVW6BeRoh+fcbPNORuoSHwInue3Tewz1A8ItdvGNeMOSRCJceKieRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

On Thu, Oct 16, 2025 at 06:10:37PM +0200, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 03:10:26PM +0000, Yazen Ghannam wrote:
> > Currently, the AMD Address Translation Library will fail to load for
> > new, unrecognized systems (based on Data Fabric revision). The intention
> > is to prevent the code from executing on new systems and returning
> > incorrect results.
> > 
> > Recent AMD systems may provide UEFI PRM handlers for address
> > translation. This is code provided by the platform through BIOS tables.
> > These are the preferred method for translation, and the Linux native
> > code can be used as a fallback.
> > 
> > Future AMD systems are expected to provide PRM handlers by default. And
> > Linux native code will not be used.
> > 
> > Adjust the ATL init code so that new, unrecognized systems will default
> > to using PRM handlers only.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/ras/amd/atl/internal.h | 10 +++++++++-
> >  drivers/ras/amd/atl/prm.c      | 10 ++++++++++
> >  drivers/ras/amd/atl/system.c   | 12 ++++++------
> >  drivers/ras/amd/atl/umc.c      |  2 +-
> >  4 files changed, 26 insertions(+), 8 deletions(-)
> 
> Try to simplify this this way:
> 
> Drop prm_check() and set prm_only *after* acpi_prm_handler_available() returns
> true. Then use ->prm_only everywhere instead.
> 
> -- 

Okay, I'll work on that and send another revision.

Thanks,
Yazen

