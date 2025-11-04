Return-Path: <linux-edac+bounces-5336-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48619C31BDF
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5303AAC71
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD689330D34;
	Tue,  4 Nov 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ar/JStBo"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F132C942;
	Tue,  4 Nov 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268356; cv=fail; b=Xl/PIYgU/cQbjveFPg5iiEb9u+8QihU2eYiFnjRaBbMjMfSukFobbpf9urqt/xNWlQ3wHtwoRtusu2vMjUomavBJ0FkI5NL7sylPupkTDI0JH9pYSZWt8gn6k0Z4u1wf0UrdIAajrRR8SAv9e1fnSxUoTxDk9g6Ewq3lNvOoxcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268356; c=relaxed/simple;
	bh=cUhaxQnsRiBP5d2ZehHHCZn0oScr6qX4gUOiwODvopY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nSrf797k1A5bx04sgXYFS3ZoQ0cr1PnAgVf9FEMyUnL+acTiGZYVtQ1uMufkVTLcsfZY2Fw0Z5OG+jAsI5drT575rG4MI2uOr+VEgWFnFQ23eYzifMsc/bjrmvkEn/LUJ/PA3v8pRnOU3wdSVz66jvdPU/motlrfTZzkZCd2pEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ar/JStBo; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMH+MhOEQzonwWZEUpb8JNw1ljNfEkuW6rlUFXR0agxYGOgHqWiUGl8JzP705K5A0KcXKop+J0g8EFiM942uZWAEId5vSWQ6OMpTvwgUPnUEjkWhtM0gqYMTEUXAWONwZ5V02dncw+8/zk612+A26RZOq/Tr2HyOBVUO5uMT6j+lF9MV1JqICYKhqA1MHn+lXiLLPEfGyTlawxkH3F9waJ0Me2LMGcvhBufCtjE/9cCkrz1waduE5BxGBdPE12BelXP7S5mf3HaagvCVISiUymL1bzCac90Mxfr6tO9VfQcaNKXk4G7ibVL+4IOQ/tDgjlfqgt4SI7jP3ytoAo9b1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wUOItIY03QvCFR+/9736HFRs2IDxtgU7UEigsOhFaY=;
 b=JXGIGzBVktuVqnHEhjJCoTlGltKaYfuOe1pyOpeOSTfznOvbjUXgdRI4I6SdScVU8AmwLdOZr4C41EOy7NYmkkjQEL+6P57+wJKBtoD+aQvZhDRl2mvherJz3SKpxUElDT3OTPbLP3iT/uhAJUGIT3maCBbTSePhK5vL0Yiq7hZp18MPZe81jLhAYJ7M/JxYYdYI7i04TmFVyOz5/tBQg/9N/HppW3kHEhLzBvel5eut3hf5+xeLD0eZChVOWxNBFtwIkL3yizsqzwiKBEIGLQPDoNKkj6RVdXLXL34qV9laGVJKvbWpadWFJJ1FBWAHrRgFwF82Rk4fERGSMg6Mfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wUOItIY03QvCFR+/9736HFRs2IDxtgU7UEigsOhFaY=;
 b=ar/JStBoGrfRkoFTuAvt/QHYzJl3r1uNEl17LRxzaoPp02yW1ACLt7T2su4yKGaPP4AuX4+y+1By2x2X/PsyXDlgTr5+yF6jSk+SdiD8uDVQ0qde4TtU7hgD3zZvT62ZKtxA/pwVI0dGa6C3ieNrrwo4TNzyn6hrVfx+ggRG3fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:59:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:59:12 +0000
Date: Tue, 4 Nov 2025 09:59:07 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] EDAC/amd64: Set zn_regs_v2 flag for all AMD Family
 1Ah-based SOCs
Message-ID: <20251104145907.GA452990@yaz-khff2.amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-4-avadhut.naik@amd.com>
 <20251029171057.GFaQJKoUUKI_VM2GXn@fat_crate.local>
 <20251030134839.GA3209@yaz-khff2.amd.com>
 <20251103211848.GNaQkcOLw5vUhq1jTs@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103211848.GNaQkcOLw5vUhq1jTs@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0464.namprd03.prod.outlook.com
 (2603:10b6:408:139::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 24700c99-457e-48cf-7243-08de1bb2b6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kyqzCbucD4o5MncAaR2M4JoreuamSu1wwSfCPAAe/Q1h8aWO5zXdlTUoeGNu?=
 =?us-ascii?Q?zBDu9fTYkPrtsoNVguu9G2aDR5tM+PZPEd+qp8RfxLB8mUa/p64V1VThjF7b?=
 =?us-ascii?Q?KMg3tOpGlL4t+HckKqGBpimeycNdfrcV6Y2jo2m6KqMqiJVu9NsNfC6OkR9s?=
 =?us-ascii?Q?xEFfYeOteWAO+cNwhgJxUNxOdvZTvH/1THcG6Kop5QOujB5/5XvFuHuTK0gm?=
 =?us-ascii?Q?0ZQgQA6frUPnNmivBXfQne0f0Q+AeychkojnKZTfVsZ00e8uqhXdCfyYDt57?=
 =?us-ascii?Q?WJpt46Go0jlwG2nBrPZ7mYRYe2fGD8hviutxIeq1C5QOjeh/I9opGdkRcXva?=
 =?us-ascii?Q?XF0d9aYIkQMlFHr/rL1W87y6cNA3jOBClD7zOyQ+XAR2Ev0+8OzIabCt2A6E?=
 =?us-ascii?Q?BiGJCH4xiEUEYdsLsKwWPAngcF3EGZmsjB+Q4hQGsxaosOXZgwRdwSObM/BY?=
 =?us-ascii?Q?Dkei3SraCDIVzEs0ehDUpTXIhuFYAUp5qjGHsXq9NT3iHDDY//U5HRJGQgT5?=
 =?us-ascii?Q?UW7Pn7QhkZlbhJmja2ml1Jm/8NU9ZVFqIFHaJWLYhFnHEFJbgAL6gZu8bsMT?=
 =?us-ascii?Q?3gtu9Gf/jj3K/PfjTKjp3ukb8v2O2M8c4J81MtIfI2FWTHlK+g9n0e7cft+n?=
 =?us-ascii?Q?lV0UnRyg/VW91kIIKQAX8otNdE2sh5htDbuI3UfGdokjtbsjGQyI1h1ZJSu+?=
 =?us-ascii?Q?EE+iPai22vqGEFdXtUvhJjj4wM07pPIKTchn+MGH5o8szTUSQgtdkgeWNmej?=
 =?us-ascii?Q?zol2fX/7X1/UphR7xryT3PfQ0zuJhHwqt3zk4RaIanhyzYnserVGYmhv+na9?=
 =?us-ascii?Q?C3ZTWMwm5qT3AnVxHsQdYdgYSbSidFtQ+gFJcXAaP01V77F98wXUqJUfeAmr?=
 =?us-ascii?Q?4LdkGnjFD8MgNQ94GrlGs8GDsqPJsnsWiLQYIw/loHgoJeToEgPBKY3Zzdmw?=
 =?us-ascii?Q?BaXjRJ8+cIYOoxAHOy7a6/6Yq5UqS7QlAzCoCDN5CtrngWBi42IQUDbhYTi+?=
 =?us-ascii?Q?Ug+8AAb0yuTcCBPNIKYPbcVfxM1PoGq+xT/XHtAVTa/H2k8nJdt5tce2gxsg?=
 =?us-ascii?Q?Z5+4koyROuFPrbccrujANaXbWREq6s5zAsiwXiLwP5H1JOluwY9PLM7YdY1U?=
 =?us-ascii?Q?RoJm+ib9Gd4xdT0mNRQ+imcLClE+GITaDFH6Mr8tIjMpk2mbJYmbOhUQcfd3?=
 =?us-ascii?Q?thvxfqSPAKHSNPktbDRV7vjN2rwJWIIp7rbRWBtds0NCymKIZBAdxoYSqgUi?=
 =?us-ascii?Q?Be1031hmEFGMP6MeRak1fhgljZcDMb2WrnoFF61jnqCWlyXga+z/fPmzD4hV?=
 =?us-ascii?Q?+7DVBegA6b7gm0BPR01mCxZErKuA19CqZ+05vFg4oL/g0NPDAVuaigl26APd?=
 =?us-ascii?Q?JCo4pd6dYloJU1hl2pWw8lsGTmA8wL+4ynnozzLvjkkPHAgt12COS6nvNcfQ?=
 =?us-ascii?Q?EFv7eJIvcAkygFojFuJHz1s+0O9sL21S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VV7DCdOHgPl7KM8PBrmHAfP9Wu+KK06UngwfvVMb5dD6piUi5eUmRzJICDIc?=
 =?us-ascii?Q?L2+nNJzQAYbTevc56n+/kunBGfxEppT6aIw8+xpTMBqjjXDHf6ZrT1OdUht4?=
 =?us-ascii?Q?RGfbMr2RYqtMPiMCI+i8dv0/Pa5LDehvkhaIODfXqb5IU1gjei4LxKwndPFg?=
 =?us-ascii?Q?yyQ7mZkAqPkwuhYPlj7BnvjLj5TsV12NdXaAP6M0FKDIHUPRICw2Cc7e7KoK?=
 =?us-ascii?Q?MtAM93Bi2e8zaYY9NA5QhwcRgVFnmmMBH40Ezj/jvxGdq8LI4O9iu9xp3hOm?=
 =?us-ascii?Q?ojNS6g2Zhg6PODCQy+bbDiX8cu4vuzceh3ymEsZyWveaGgM2BofqpfDJJ3HN?=
 =?us-ascii?Q?CUe0XhTALBQ5788mFuCFiMd7SXOlcaQNLlqSI0Q0sK+Nwwlah4r0ReplHlsm?=
 =?us-ascii?Q?MV2wsM8m9fdYCipZzhq3aiQwcQWMWrBgcFktzY5iBIMRfFor0oX/lVCPikpV?=
 =?us-ascii?Q?Z8llOZXBfoNbOhhBrr0reJrw/jrsDVens43XB1cLJI8AAQcTLqi/qT39WUaP?=
 =?us-ascii?Q?nQ2l3HLTdyltI/mi48GbT4kSKedLJIyXiu8WkmMSRi1wGgOq01gAr70a6QnD?=
 =?us-ascii?Q?oIcPCdQ/gt+7S7zjV72cMN6yGdwoDdVw9Y6gYsEbKvnOba6lvda52bd6inlM?=
 =?us-ascii?Q?mwxLfFVVVAv9R5Hm2gOL4AvySDuPsap9pIdvAYOWayq8Z69+wW6121YL1VET?=
 =?us-ascii?Q?AcVhtui78tZ0ZQ5UtSKQrCtap2NPt+ZYY+BXHgfw7lnXrDBXFH8m8Qusrtk1?=
 =?us-ascii?Q?LPSL3cfwdn7b4d4nirCdLcT5tSGxwP+TLQyAQx1+kwrImqGQNRZKOTrallT0?=
 =?us-ascii?Q?w+8ysyOzbf3D62u+3i99A2rVDrnxtmkTPE5yLQ5hGjfS1uQMWyL8MjFnefBB?=
 =?us-ascii?Q?32DHOBogRImZOTVmuKWe3vp6E42O84Sbpwrz8VWYpf7NoQRT+co74udFP4Kv?=
 =?us-ascii?Q?x+SiGi1WvMjG5E6+fU9PM+0e/zt6wY3GZbCP84wCTrclDx8twavucSTG0jci?=
 =?us-ascii?Q?9K1ZMe+L+6Pqu6MAlw/1jtP4rsp9cXKHqaBwb30CmX3+uZtWZXo14mV991Jo?=
 =?us-ascii?Q?mFMf1t9gL8eRiJcp3jk7igqXA9uR4242ma1dB6Dz7T3Q8JFRvUqg2no3v8Vd?=
 =?us-ascii?Q?Eox3VlrBtusx+zTVHfOKO1HJecWBhTWiD7lkjqqte0HS5QEgmESu26s4ftYt?=
 =?us-ascii?Q?t7uvYj1FHKbqg4rR266y66XTGVH0UN+eTYZbYXO7EFNjui6yc8jPHLx22so+?=
 =?us-ascii?Q?Sgro91NSUjNUKWQXed/wpl8RV6Ih/DqYSowysL8r7BQHcxi78FsZahnYWfce?=
 =?us-ascii?Q?2vTZU2+E000qF3yq51+SE1DBJxTHqv9WxBkM1q+tKTzUZVrSCwdWyY10RzZp?=
 =?us-ascii?Q?sHJRDqwsJDwz8rBtfpkmNnQK9QT0YMCKMFh7VKjNEp4K/446mn+J+M8FY6nD?=
 =?us-ascii?Q?ULB1FHJS1RROsGBPsjb6tdcZqyLJBgQjnFI+pRvdVpSMkhs8aBT7YGoXbIPt?=
 =?us-ascii?Q?asBr7JcpWMKhFESyI0l8OI44NDhP5V/fJvMdcvCp85MDC+Q9O1EE6lia/hsK?=
 =?us-ascii?Q?KPsQlljh1kQRjUkTOIfeDgE0o52FHYXkQc2zSvJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24700c99-457e-48cf-7243-08de1bb2b6e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:59:12.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iGBJ71jIn1LDAycvksY9DgICWy39YjNRr1G87e8C75ZL+U8Tx6cbuZX77ONGt8xiQV+oWprjusnw1Vj2vCYCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

On Mon, Nov 03, 2025 at 10:18:48PM +0100, Borislav Petkov wrote:
> On Thu, Oct 30, 2025 at 09:48:39AM -0400, Yazen Ghannam wrote:
> > 
> > I think we should take any opportunity to get away from family/model
> > checks.
> 
> But we're not getting rid of them - we're just partially hoisting the
> zn_regs_v2 assignment for some only.
> 
> This looks like an unfinished patch to me so what's the point of it even?
> 

Hmm, okay. I see your point. We can drop this if/until we have more
substantial changes.

Thanks,
Yazen

