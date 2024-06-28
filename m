Return-Path: <linux-edac+bounces-1434-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73191C09C
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 16:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C9280DE1
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E9158858;
	Fri, 28 Jun 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="to1c7/yf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA0155747;
	Fri, 28 Jun 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584154; cv=fail; b=DHc2dNGhMxIOpyeVahBWuqp0E97ji/r1FoJA48uySf+d00uGlm6mpO9xyDOyhZAOZLo412CuJYTWxAz8TtXmyvb3I5VSliumtNqH03VqA5e4nQ9lJqmef71jw6FktD7c9TfabFz0sBWmqw/JY7gYB9ZvKxYZdxFSDw2HmJkUN3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584154; c=relaxed/simple;
	bh=qObhPfvdK98OhoHVm2IidmrAG5kOj7QH5dniL6FkmGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bw4vqP2+H1gJjZdN7srRgRHjlOvbnW4Lhxnaw7Te1jWZ6huALeEhPj6ZNS1DXw0JU71XGdTr0xX6QcwW8Z9cQTh/GpL9T8PMtS8jvyD1iqldQyqIWSq2Ix6Y+gAyiWPhm3xq3pL6HvqRF++eySjJ+o3EQ37YWQbjkXCJUP4ekoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=to1c7/yf; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDYgJc+adZigdBHhRY+idCcqGXInJIEmvbA4zWmA7lk2SE6KQiP5+anGxOIS5SrABOqonikifivo9hrJ6JwxH2eBFV22HFn2vwy8X6/ZUnFzJouCreuxLorsNM6x2gAbsYc/IXpuOoXQ4BWKdVUm3mNhWM5oKGG1scS633IgtgH+w45KVH19ISQ34In2oORRh2mgnruUrKMB5O6yCiog+51vr7u+KE4GwA06RYzwD8y0HcvN72Vj8DHq4CAMhVPQ5sQe/AvxDCZz1hcloJSR7Zm3FiqQ2DsDAfhQqP8Wt3wM8VIXGSltTPh+vLG7haDkcaz/2AxSAiD3MKOzRTtgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W0kSSGTBjMaxROKCgVkRA6K6J3WgqICWjvr+m2tE3s=;
 b=gMTII8iagp5wNduXLruLebZ2Nt8X08HZyOhVUFYQ42T+QKvJhbIZZ/yTtCVxfxvEgGle1V/J3CFiNsRbK4kG6rG1h7G4KcCOiXYNGT4rgHt2y6JcBAr+5mO13g7hiYh33Zfwftpdt2aHY5rWwKOsihJF/vv2ooSHD0FDEmd/wr45unpqgiaMWCY0aZOKqMt1x/943msr627Gtf3j6xvnIkeROBKHRvexU1/IV9C76Zm/LQ8DzHB6fewGIBm5VkWJJz0UDsTToCBv/6O9VLVW/U/IWdt5WwLUbpcgnfeZr8tfoIur/pJzCOcTBONmZ7htWxTG6sLCf7V4ZrVNqTZG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W0kSSGTBjMaxROKCgVkRA6K6J3WgqICWjvr+m2tE3s=;
 b=to1c7/yfK5zlS4BOTsmVHQaXXLIHIMp2Zky3Uq0NeuKkK9ZBy0zn0UmIw1D1P7MDe0/r3OIcZ7zMhNDwzt6DhvavWRDHqbKjB5d0oCJJAmKhvab5cYumxiQJAqFxKA9msKWRemdXvThSrOp6c9pMMcpzUSWLM9K80rYxgYJUPfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 14:15:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:15:50 +0000
Date: Fri, 28 Jun 2024 10:15:42 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240628141542.GA124261@yaz-khff2.amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
 <20240626014212.GA1086@yaz-khff2.amd.com>
 <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
X-ClientProxiedBy: BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::7) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 00feb015-3958-424d-6829-08dc977ccfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gJSAVa99tNn97zyp8/jj0vaFU5GQPFxhmpqZdE+QT4Fcu+phlE2vuewrpXK?=
 =?us-ascii?Q?lElKSZfstLawZGfCYutCW7blBtvSuDGQRxfViuWEO3ZnG+f2T1Tbyc0aFkiv?=
 =?us-ascii?Q?jD0byPXdxg6wo76ANdbJ/DlVEbwLUPedkW8MEBfaJgl+J+bHSmfrb0k+C/AJ?=
 =?us-ascii?Q?3JJ5jcUPIV99z15MNw02vY6Mpt8lV+oN5Y4pzD12vNEhjrnJEWTeEMAKIgmL?=
 =?us-ascii?Q?A/8OEKK48s2kZMDGFK27rL/kkFJ0ZlK8bcXKpxvsz7RY5JlXmVBoqbBNfqRv?=
 =?us-ascii?Q?/Q6p0EBMMHyKtUHVndIqw3BoNwTV07awhTWL8M54SRlqlvae63xUoD5cRIuC?=
 =?us-ascii?Q?FONJLhxKSpIPGj2/FBJh2HTcANhZPt9gWF3pO+n2PZHguwUeUKYBVqdJ695h?=
 =?us-ascii?Q?Cg2jYm6qJsoMfOWUVn4yizG8cBd0VwuEi/al9UamlnuIQWa8BJL6P/+/ZdkR?=
 =?us-ascii?Q?q1OcTxqghTp6yM9R4qSDvAcNS3oPqtnq06cV/s+zqIx82GMpJWseOLw2UoXM?=
 =?us-ascii?Q?5DK9o03fUwpEIz7NX2Jjpb54PO6CneUpgdu0tpmQoMNLVaF0HhIeDoA/jcSs?=
 =?us-ascii?Q?v+4eVGOfOYQRwN+iKksfFhOQNDsbK52GzioglvfkaIa+7zrQsqhDKQVZp7D5?=
 =?us-ascii?Q?0bhUcSkt8f2qM2YMWsQZmfLvqCCMk5pm/XQT8ljh6R4L0nNTYFO1EhaktOpW?=
 =?us-ascii?Q?TR3TAkLOInxu7SRRXx36UPTQQEJdlAIWEGZoDtMoTjXfTBz7uwYMdRd5QJEQ?=
 =?us-ascii?Q?bdOexVFT6ZI0V/chZldEPBljeEOaXRIiV++LXzWna1pOaciv/vl3BLeY6LOR?=
 =?us-ascii?Q?WVDA89NyV6TrH4sRDe9yMgeRuRKE/MTgM6Rhxqymx4qJeAD1I6VTkMcGfgXi?=
 =?us-ascii?Q?XtjKCUKJUpzYwI+YHoZE5AuEbwyquKsqxfoaPWWv+pngPoGWlV/F8DA4I/To?=
 =?us-ascii?Q?UrPIO4EtYQG4omtquGNpXxiLKPfKOLGtM+fizLB7dyGw8Vyh6XhbBXdTfwHq?=
 =?us-ascii?Q?o7qDXkxgs5X+0Ri6H7z6FHRIOoSG2CkD68uDMS3IYSAHtcXJ9f9A63K9svD9?=
 =?us-ascii?Q?zpOnRdHDjgNfvbUMHPHiSkQswOX/UiyQsWintroMpWs5CHF8Td52S8XEGHeB?=
 =?us-ascii?Q?ba43R+WxcvlZSDb7KZjnXP4o70Uznssxe1j3xWh5nNKM7qNcO/3mQTA4OGyn?=
 =?us-ascii?Q?uXXJdvZBizcbzGQJhGZvlW4D2cWG9Mv1V0lZlDgmW0MD60nIVrruQFkFJl6b?=
 =?us-ascii?Q?TlEvUu2m81sZEcPy+WpyBTvbyiY3kF9BRGjsKAyxdpzxS1L271ARlEZk2IqW?=
 =?us-ascii?Q?Vi19QAOAPqf3EwF/0GM9Hnd8aGw/h5wEPfzOChyj38H8/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QD8ezY91K5f1ctaytsdPfsthwZQUBQKuOkKdxYXg1nUE63Fu4kZ5K6vE+YAN?=
 =?us-ascii?Q?ZiqSTz4eR8FWvj8+RVx0WLgXB5J+HccQvNLW2DDvpd1vnFR1wifq8wfPOkZ0?=
 =?us-ascii?Q?5mHzV6M8ZauQf0q70cNEE5X3Jf2UjWHjC3rhK/kbY1GVZk6j6NUXmuDGsELS?=
 =?us-ascii?Q?PlEGBnqhEasTpE0YXs+HjDpXiNW8SvgPMoKm8LPJMYxuEYY2pdAu0HZ73y7q?=
 =?us-ascii?Q?oOb4p/qGafWJJfbsxWdZ0wfWNc86+gRfFEyzvQwZW2OPuz589yXpXgHMHjYs?=
 =?us-ascii?Q?Ju6UHsPd5UOQwVHQfFEHRjyhl4JHAQz06qBUfEzr6OAXbOiZw4FVliatXfk/?=
 =?us-ascii?Q?Tx3aW45WXpZzfh81lcUaCw+Z+SY6jZuNGijm679vy1XjBpI7yLsRvwoY2Ulc?=
 =?us-ascii?Q?QjFpVutJRqLfajfpcyfucvjZtt+HYJ2T7dsL5FO1jksYGqQr6jJ0Spr/YmOF?=
 =?us-ascii?Q?sNNCUJomjBNen/of/WH1DMx2IC7BKdj52UNvWRC4BAA+ApxtjIIr0nkj6LcE?=
 =?us-ascii?Q?NV50YcHg4b8Br6lr9MW33VFJkskFkCfh0va5/5c02nlMHDbNThLTd7JT5cc0?=
 =?us-ascii?Q?hFdb4tALqnjySqks1cTXJv0uA2DVadAgLZ0SlnUtQVhH2ZXqui9xs3StYvD0?=
 =?us-ascii?Q?qubnxFtLHzl2HzWnUFpNEOhvdlOxuP5Gu6l+UmEXz9lmaTGTJwyVYE7XWm6h?=
 =?us-ascii?Q?QJdcGCfrNDH7cFr063nuEjyhCfC6j1EFWE5OMAOKSHIbtjmDl+5mniCGhIX7?=
 =?us-ascii?Q?2minYtbq0jnXchEBG8c1Uft5rztVXIqVik80cLLpqxtFcigd81XdVFkwVE0r?=
 =?us-ascii?Q?QQEZz8L87r272MX5zrtYBVVyW14rtThGaAiLd786/Xzbxajx8zML+3crSdYA?=
 =?us-ascii?Q?J0Vsp+LnDUwTmDyeFzYi1/yWS69Yk/xJjG2c0n6fwFqV5zgOm4aWtcdzi12R?=
 =?us-ascii?Q?4gJabIgohzMRBjfkhPcL1DyJUJtedpi/rNifkawSb8mZeUfL07JT2WwrwR5A?=
 =?us-ascii?Q?yCiTGfllIUeqxD1pD2cBaMyfuNPpY/HJKcGkyzGHjc6N7RqaYz2mIajhxdi5?=
 =?us-ascii?Q?HEKkd28RPkmo6PdwgEuzYYm3hwobU0xn0A6Ywe4u5VSrTg23qYmJL83SBZ+O?=
 =?us-ascii?Q?XeleAkd29kgImAxKsmdEZ9FWn3gS2qb9QWRMzHJ4xxB9IMzeN6RsNmn0BqTo?=
 =?us-ascii?Q?gpoTxEDkyH2NMLu3ipo8G6Mn7G9qayoXRA492yfJQnQautdxW80PN+UjsPpN?=
 =?us-ascii?Q?A1vw6FCdQrou09ryZNp+HfWZINPxNB2P1wZTrD+nJS1SUPlvatB0Eywk4+1s?=
 =?us-ascii?Q?NpyfM2gp4q1IxGKZU7ys3nV3TmolnOfv3Hg5r1Z6sVT5ko+25jBPkTtt/ubv?=
 =?us-ascii?Q?pkxf5WgNTyhLtlLx6hJmIC1m/GfoPSi9/LBoIv5A2EI6ULH9F6gPZrLsMICc?=
 =?us-ascii?Q?SiFwHSZbZJlHDYGckJMoVMDbWJkeEjxADjlSdt2VhY0SphIKXhNyInDbT78N?=
 =?us-ascii?Q?aJRcsf+XbpMy+5gXp3MEss/mZuhc80Q6o76KWeGQW4TYfYtTB8ZaVVQxp/JO?=
 =?us-ascii?Q?hlQEhB6ZQNIv4whphk5Up/EB0AM65wjATihCPkY0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00feb015-3958-424d-6829-08dc977ccfd7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:15:50.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zq8eCFUQYdz6nQRIcw8SLZUJ6jwxid5Ph8HWYeRWtPHcUVcS7LoBF2Roe9CVTwKrKExEkGI/KCTJBkIokvgvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

On Fri, Jun 28, 2024 at 10:37:22AM +0200, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 09:42:12PM -0400, Yazen Ghannam wrote:
> > But would/could we have SMP support without X86_LOCAL_APIC?
> 
> Look at how X86_LOCAL_APIC is defined in Kconfig.
>

Thanks for the tip. It looks to me that SMP and X86_LOCAL_APIC are
generally independent.

Thanks,
Yazen

