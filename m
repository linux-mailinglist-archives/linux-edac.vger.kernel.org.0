Return-Path: <linux-edac+bounces-1373-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49D9175D5
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 03:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBC11C21D24
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F4D27D;
	Wed, 26 Jun 2024 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JlI9d8KS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD58C1A;
	Wed, 26 Jun 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366349; cv=fail; b=Dpg7z9PqJbL95c2e7Eq4luHzDEAdYGEO3Ktx44EjylpD4UFKPeuOp1ed2aabfKFH4LDEyMHebKovU7MUf0qv5bSAkpyUgHXCX5iwce6Qizxc8M+b2v/UoFeLSXwJy7CTY0wSsp1F2/0O/OzdibXl3A3S2GxxQZaWJ16fkKVNURQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366349; c=relaxed/simple;
	bh=2eam6t2A4C0rp4On/XnewUlUBJTua5SgLglLSnieuR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VtiAXZu4JYuPKIDXO4Ego/UW2APhLBs+jDMdVV+i843JeJ9SolBbDGpBceJYnXUIGQIcj2bqb+1zH8I6FPVG2KbYdJB+Nua/GvgMRCCZ+ugpyBEWNlKttsud0RO/2l+OEnXp/Kn0k/tVUwmwK0TjvDdH3OqafUPT97/IGM73qNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JlI9d8KS; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5O1AyVBTm4krp7LgidOD9fIvHnn/WRDMNX6GaqiP1auYsM1TNTqSyGv/nzx2Gyc3g1UpkOkSGeK6Mrl3yxz+0t/YU/c5xedofj0M/T6MT1U6U7Cc2OBicbCX8iFXruvavdsveGq0CmxvUjyKvGyqjH1WeGbL1ZwKbXU066ANmt8xaijOiExQjNLj+cQVXCM6fRiqqNcVS7ZgPG36fEG5hHFY4DwmGMFWGaHqiOPpjjXcFFI7/9CLnLj5CCc9indlBJkl0bOwl2jf7klx0yASHLj0fPHyycp8sAz5P+5fg85GtlZdMXwlS/GGdC0jd4bgv6KS+kMo8RgAw2MS6Pn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJrEdFd2AuoZOk31b0Yj3EsnlQw+XjR4vCcuVcHZ6fs=;
 b=U0oCVkzA4OXyHilZ/elzdFp2JveVMyOEIjNEgi/u4sjp5RIZ7x8Ra7q9U3TBCfKVsDBRpMlj6UyTZyZptAzYpMD8p6t6Ksq4sj0BdYt2R8Pk8LqzT3AgawGcOSvQGQmOy4pw/saeuI/wfWQSySXTHdr6rBBJBT+7Ngxx19akSz/ZB9zYgi4th056oLPF9cagJ6PWZIy6sHrXbmQ9cl/6mteAiRrsr9CpzaYYXb3t6xQ3idPVP2KWQgNta5pVADXua8QBpRSxdZv0+CqLoPqtmIIFFVxTIBJR4vBZKPeQVKPIB64vO2HZFZ3xwqHkMq7Kgyadxibf6eYr6svjdvaobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJrEdFd2AuoZOk31b0Yj3EsnlQw+XjR4vCcuVcHZ6fs=;
 b=JlI9d8KSjOVY2add0wiC95/9XWy/fw1yKyLsn0/HawPD8FG4hSz1syr532HRtt+QtBap74+BncfYMJWwtxniUlvlVZ/nEiveEu6w02cR4VoVj+T45bcTbhoyba1W20kVyt+jFvJb2OlOnZ0Rb/9cb2+p/Jx+LsYKQalkFmisOVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 01:45:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:45:45 +0000
Date: Tue, 25 Jun 2024 21:45:42 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH v2 4/5] x86/mce: Define mce_prep_record() helpers for
 common and per-CPU fields
Message-ID: <20240626014542.GC1086@yaz-khff2.amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-5-yazen.ghannam@amd.com>
 <bbdf9caa-7c0f-44d1-a69d-a5cecc7cd4fa@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbdf9caa-7c0f-44d1-a69d-a5cecc7cd4fa@suse.com>
X-ClientProxiedBy: BN9PR03CA0958.namprd03.prod.outlook.com
 (2603:10b6:408:108::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: dc74669d-5daf-4dc0-554e-08dc9581b241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9wbkhuP0eiKsYx+sggfUIeKjRx+ZhTkHx5IN6c8dNxvRpTPFD35mMfcpFSq?=
 =?us-ascii?Q?sfm8LFQ7T6nJQlbqb/T/YytnlswYr2hrDly1KlnUMWK3vnLqFyWki2vtU7LE?=
 =?us-ascii?Q?8mho4zxxJMoezvNHHnFSa8Fnah3p5Kl+L3itCsiydiIPXN1QkGQMDjaEpRnO?=
 =?us-ascii?Q?GX4S7Z0b67v4DddaxGt0D9/8TD7LPvEG0D3q4ucjQYrihRJaQqHumIkNzjIr?=
 =?us-ascii?Q?WbvKYYjVEQ2RYtfppnKDupAR7vY+d9F2Wd5natui2bgG59HMLU3NWaonkQI9?=
 =?us-ascii?Q?YzZuqTobqwHhB1vILc8M7BmAw9suNBvENVBXxdvC58JZ01quwbh2ZWdGJ0RO?=
 =?us-ascii?Q?YOjNTIe4CUGN2XzG+aVxnhuYwt28RWqlYIv1accRoML9qUAxE/wkJDiRrzW0?=
 =?us-ascii?Q?6GHbnxtblBSYspacWK5Z0gDSzC4rKjIOHPgWYKPnOc+iubESnhjf65MB1BmC?=
 =?us-ascii?Q?Ydh+QrH8hrvGNGqagxawH9QdNGNamDxg0xwugNB8x9v6YwqaXB6hvbEwpi2l?=
 =?us-ascii?Q?NvJ8oqkCxxeiZaSmUDT+sZCtK+eLDk4AUExYRz1h/J+pdt42vubg30pW6Tkp?=
 =?us-ascii?Q?c9uxY1lqwCXlgvreTp8P5/jwZiEcDdnkicVzgqOOQfXR1kbiZWXg91JIq9kD?=
 =?us-ascii?Q?842MDCifaSSw0m3cplbZWWveuj95k9ko6wtSvCz+afghgQdISH7/BIwd5ZBI?=
 =?us-ascii?Q?WzNoC9jLQxFXGxsyuicYe+wHpDtyg3DsCyijhUtr47HR/G/6N09sIKEoi2ve?=
 =?us-ascii?Q?nyqx+J8L9vBrab03Mc9YJznRf36dElI5zJ8EpyWiRU63UFFflA29Ddk76RQN?=
 =?us-ascii?Q?FX2q+gzVgnTDQe+dlJnfY62RR7VD2DUYD6AmmqvXwdDxxN48DAYbD2txcywT?=
 =?us-ascii?Q?sDhA9DogJTRyoOZl5napqnpyC+TNmyU1C+FLLosEpcCRJKgnsZEdXhLbo3o4?=
 =?us-ascii?Q?OCDXvp0SJVWGIOtZ1optL4XAqyPuL8UmVWkJd5KMujRKgY8EWKWzd2KTnUZ3?=
 =?us-ascii?Q?SpsJLB2GfIjHJE1RzKbACGilg1D3XSD7Knh7N+h7EVN/gIDsuSAMpJbqcPro?=
 =?us-ascii?Q?ofyhcCYLDIopfg+c0HIdFuaMMD4ESze0D5a6u5812Y+lJujNGLKQKp++VmjK?=
 =?us-ascii?Q?JNZ8sx+kQ9+bZ0ZWUYQwIwNfyVOlemnYpuPjCdv42BluiuDANtxhq1PK8nMi?=
 =?us-ascii?Q?pFUkHmMtgpix/A86f25yfPdn3fVyZIDLCB/tDY8oIuFmm/djKOybW1iSKuW+?=
 =?us-ascii?Q?zN3t21uhg9UJzS0I0sy0qtEssOxesg5FIPA3uUmTIjVCg9j6G4E/NxtQFf3L?=
 =?us-ascii?Q?rZYxOvFEtU7RzNo8DeqQSRQA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gbmFjD8iICMj/hlSMFbS0vzr7wYxrVCY+vr/7KKJz6BEuSigXqO25wHTspVY?=
 =?us-ascii?Q?ZQTPIfCiAxb7wYeoc137OYsCOxJjrm9htT6dzFR9Rbc87re/W9SDPsLpQOm2?=
 =?us-ascii?Q?67Fk0zjDrjrohnIA+8/4b4FDXcHS+qMXIFKFUCn2/FKCGqn52PKGE4Wdk2k/?=
 =?us-ascii?Q?lbqNCKTJqhG3VfpzWEMU+EQTjQMsf3yz8vHtipHRy14jAr/CEDTdbXpfWq2O?=
 =?us-ascii?Q?8yKyAG1SwTEc5vuoPipYOICnZhAt4x3RxKeTcaRZdw/Ak1TlPbkyq2LWWDtz?=
 =?us-ascii?Q?zN6gn3amZp7TD3MDLDO/riqnL7et9cUOcouLT9yFaRB8G88ey47b1/5PcNlT?=
 =?us-ascii?Q?lEGLkUkVl9e7Tq0HBCA6YRjFFLi5orW9q2n3Pn1bHsD/B0rqRno7TJk6s5Ki?=
 =?us-ascii?Q?gtepkg9efEnfs4RPWVfUI1x1WBmEyMgSnbeVJzDRetUlatcurvtEVQAjx9LH?=
 =?us-ascii?Q?ger7P4sllnAsN1e27DuDOv8WUYZoQMoCtBv0FRCICUsJdBC8l+JmA5N5fITn?=
 =?us-ascii?Q?FmgmItVdIcm6ITmBReNHCGsx3+O4JZA/yZNRP4b344bxE70jS3PlQtEbLOU5?=
 =?us-ascii?Q?kLycKjhzzQpNb+nGOHoiEZRIpvTe1aGCDCVbL/RZ0RsPfN5w7ZF7dCGnKVux?=
 =?us-ascii?Q?m7svB+79V5JhEhVa/MeP9rMViO/F9bQ1yLszl2wh12y4noSFoDbAwmYGktDc?=
 =?us-ascii?Q?CAZjG7bFKfrDxGYaIkA2sc+ri0QFEJi1ySNgdpN7DdiNucjfXEbBeJmx8TtH?=
 =?us-ascii?Q?P+f3+RxhjjIZBMPg5Onr1xDR1vVnzDeSDeoCOcKJcW8iQ2lewhRtwa4kptwS?=
 =?us-ascii?Q?cdSZ9Ooke3g+QJJH2atet6sOx/Oz1/0C6hkcO/dc6Nxb/haLgJ/9UVyYkLyg?=
 =?us-ascii?Q?6qrtHFi2hQQBEhwdQ8VVv8oBqV0MaaP/Hi8BK1s9GURF5ew43+onGt8hyoEh?=
 =?us-ascii?Q?AtCEOkkC1MUgW6TbX4xCRsmIO1I5kLdX+8k2YjdL6sE20ppEU1U9j38f+nrs?=
 =?us-ascii?Q?ucd74WSSCxA2T2RozjqCaK/+m0knBLXTKdqSIkeB/qyUL/mlXcaCWnMJkFT+?=
 =?us-ascii?Q?FptsfJPgp6+ek9UXaWpbIgR7o33kjX9rBAv6rOrGtRGQCvyOrYycuaiDRBEb?=
 =?us-ascii?Q?dLfwkyHvE+HSpNRJ5xhJMuNoLp+lKJtAMC/E100KEgpLQ2NXWNuST2yTuNg7?=
 =?us-ascii?Q?wCyBqYDoSTokMZFAxrvj4sLervgXhBF1OGKtP+n+pITIyR/OXko3xo7Ouvjw?=
 =?us-ascii?Q?ovpvz8m4VjUk3Y8RUUJBWwCGeLV43/x3XEwfZiZqIdOJ7NpisWDs1Rh9CsOk?=
 =?us-ascii?Q?vfKKQFubTiDhD81Y4U7rAwZkoe9+yL5SgK4CDDnV/znJuRDuywBWgtlzhME6?=
 =?us-ascii?Q?4KTUtZweeT73eENMnx1UDlOSuEXrVZpGE0Sq14pTvVVuOlm2t1OX3/K/K43S?=
 =?us-ascii?Q?zjFyctw7u+UGFi7yz1qTJyHYlv6PZtvWPtBZTSmM/FvgA8GzuoKRAiessTsT?=
 =?us-ascii?Q?pJiOc85vqLBLa8Cu/ddlGRUqZHN4FOT5kKLnuWMU+jLyKEB9AKFYj9NuvhsY?=
 =?us-ascii?Q?dxvwHiaWRK5HaChcYaMeN0slGF2rxMUb2OlPZ7ii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc74669d-5daf-4dc0-554e-08dc9581b241
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:45:45.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugr6OOwXe7XgEixj+5aYDfdQ6sLpIAhVxdPVer+Qfvk5zM1XNGc1cjTGyqdv3fCH+Ya1FU8PWJ1FO7pGpBvzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

On Tue, Jun 25, 2024 at 04:19:40PM +0300, Nikolay Borisov wrote:

[...]

> > +
> > +void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
> > +{
> > +	m->cpu		= cpu;
> > +	m->extcpu	= cpu;
> > +	m->apicid	= cpu_data(m->extcpu).topo.initial_apicid;
> > +	m->microcode	= cpu_data(m->extcpu).microcode;
> > +	m->ppin		= cpu_data(m->extcpu).ppin;
> 
> nit: Similar to tglx's feedback for patch 2 you could use topology_ppin()
> 
> > +	m->socketid	= cpu_data(m->extcpu).topo.pkg_id;
> nit: topology_physical_package_id()
> 
>

Yes, will update both.

Thanks,
Yazen

