Return-Path: <linux-edac+bounces-1734-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E395F2CA
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2024 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E9CB20AD7
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2024 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF118454D;
	Mon, 26 Aug 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w2+ly46s"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20F328A0;
	Mon, 26 Aug 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678466; cv=fail; b=aXbazE7T8bbfSHqGwfGZ8oQ+kYRpHFauDi+gErV6GvtMRjwiqff8q6ditcqM1cUjDDvRCTrc+oAXC7g9co5DvxtRO7hWOxUD3jnFIezqdN6QS1l/8FjmT3WB40YEVku0UsQRGXSOXjHI4vS3EKWtjzhCu4+1yQ9mDtlFptVIerg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678466; c=relaxed/simple;
	bh=wWn6AOiSLR/bgo2/YGZMW26YOCmxG+YjmsUxCB8bktQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjpWSQrP+8WYa1f4GTLvdRs4/jXEFX/pDW0iR+ExYqGo1G0v8JhVGF6sgxn47DlUxFG+PSVTBG1X9OOnIx/647/jiXWVRresU8WTlFzPpyC18l5cu2cEX8nugTnJl50BUJaqZlpmeITfPuTSsYvwe93jFSB5JZZyw+8MKkiKNzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w2+ly46s; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLhhZQL7YuYzmcw5grK7PkWTAOHUHy0UmQAPHoXoaLBggFz98EjGChlWPIQtRgPbzSaZQADHaJp30xvG5QPl0lZYRiCfEbxJ69yOw9AH0xJDaSBcwOgD89LkCuxP6UU9xgDxwhSTIPlOPhiADFHnGU9fJjHdnDVlhg3arzc2rhbAxCjCMUweuic7gTiM9/ugqDC630oCX/E2zgyUtxPyqDXg90MiK280386Tp1Qtf8ePN6w5oMLkYpqn//uIijNWOX3GiZIDvVMeGpoZWXHEvS4wFACkiDUq3R7/3ZR4ZitPWtuZ9uGz6Q3umfB+Va7EvnebmJNzJXMlVFqyejjitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1wDKpZuJXLEOX2at03Tv3nCxvft3N5YanspWXMYcm4=;
 b=Hhkw+OPXX7UA/1llqjy2iPZhFwZwY4bX9LDbxoQacs0MfaOa41h6t9kXxKyyXXvfkz6wXSbUErPABADgM3bCjuzSbCx9tMRDmUtfCIfUbLGwG1i+A7AC3ra08Fx7PKQ8zZRFjNo80q9N1Cdei7CW0CtTUHCHRPS1/ilRqkA1RHrwWZnLFQCiRZcWzJolKlxdG02JiL/lUnIFUrphUm6zsiT1h/Gh2IUeUeQfx+NRv807yH3Yz7P0YuiKUyFnO9vPdSmnhwFP+50gbY1JnNEvrru4Y0ehlBqQO2A5Bic/Wpt9e8+UzcJe2LgtliCVh7LtR0B/e+i6qv96seuYpcuPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1wDKpZuJXLEOX2at03Tv3nCxvft3N5YanspWXMYcm4=;
 b=w2+ly46sj3TXmeixViMxBhVDHI/JeA5N6FLM+OLe9WnASGTkmvkGnnfo+TQavuR5nYCZBmczUkLn2zAwtBy2QDG1X4gTaRCM/RX+434izNkFTebicldTiWxuAcUqE+H46q0P+ckBDxdme7E7KxvFOZggLjIos0voZrsAKatFGCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 13:21:00 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 13:21:00 +0000
Date: Mon, 26 Aug 2024 09:20:57 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
Message-ID: <20240826132057.GA449322@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
 <87jzg4g8dm.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzg4g8dm.ffs@tglx>
X-ClientProxiedBy: BN9PR03CA0657.namprd03.prod.outlook.com
 (2603:10b6:408:13b::32) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 0638df14-b62c-4766-02dc-08dcc5d1ed8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWE5qr5QJ2jwKmf8X0O3J90SWNC5MouuDadDqqBSXEVIbjpfmt7OVWHOWr9b?=
 =?us-ascii?Q?G2tbCNJ5tD/8uPFvDMjDvPeu0f6WR+jwgef620oHQEWNW3HxmfhT73yfKyHC?=
 =?us-ascii?Q?CGWmEKvBHLuyhXRYkOnxTYnmt82frDiO2Ma65+JOaba+F3P3E95Z5TqQj6GH?=
 =?us-ascii?Q?atYpILYtiZBLNFZwypQa1icPmdkA1MhXr7vgjXufSfhE6qOhQbPSwAMoRl7f?=
 =?us-ascii?Q?c2/tmF+yjEvBTw0dITEZaVIIH4VIR6GabyRIJA9wjMZtiRK939X+EopZEH3A?=
 =?us-ascii?Q?tA0+CvtSeXZ4uy+MHyTgUjsgIkDeN/owYtoKAGECg+ZrMQCb0puNlP0ctj7z?=
 =?us-ascii?Q?OsdzD0MdalSNlV+sPRQu0BSQcRCx61m+IBBOpRWdV21jn5oyO14lH9Cw235J?=
 =?us-ascii?Q?HnScKSBPIa3+EBxA4Q6dG+by38ss2InKkgi0Y7pZ7cZd5tpepi7t+/GIUWcG?=
 =?us-ascii?Q?g9Mwod9f94V30Q1v5Z+dG9fLvUvjz2CNNCQRiU9riINvqY6tPbnxspF58PQi?=
 =?us-ascii?Q?Im/zOOjfHdZP2I2WCxgMhr6fl7GH3GwdR2qMGjIBdGbl2wMsS3C2/UcZWbpj?=
 =?us-ascii?Q?4WNXKUX7vaJ9gHh13eSIN+baBxHoX3Whgv+C4ZM9lQLpzd01hP4mkXu8MUGb?=
 =?us-ascii?Q?fPSKUdtx/7BWHtfYZF84ZdUwhur/hHX8pis8LYEB1M1J3gGANmBKTktayDeX?=
 =?us-ascii?Q?NR8N3S7kX1zry3LudkuLuKKdR0emuyZwSzr6LsekcR5ZELmWHTV4f0eAa3TY?=
 =?us-ascii?Q?6xospLNeEhl1wR4Mj035HUBVln+fv2zPGBWxF0UhrDAxC1A5WhwAD7qxKcdW?=
 =?us-ascii?Q?1KwDo54ykzCkzk+aN1GzIiAZ2HvyRVhLp2LtZ+kM4nMbknlR9JDFI4uw90dt?=
 =?us-ascii?Q?775OvALOghrb9iog4kjJxSj+Cb5OVSbWlWJGs6zco9zL+gsA7JDPeWlZ7Kx3?=
 =?us-ascii?Q?qSEUjTfbv2NOgcUAo3uXKVcPvw8XKLtKq7/xSGKVwYwFEPKsq559ZeNMpZCB?=
 =?us-ascii?Q?PjYE204wbKQM/5q27vAEt3a/xtW+Q1EKaoqXgn2YfGLqR1gJZnoz/fgiKUWV?=
 =?us-ascii?Q?o58bQ5gJC3l0MKdBrXzM4w7lRs69zY/GrQ9onDl0lUOAf76MfZLqqJEjeVNV?=
 =?us-ascii?Q?yrDsJiAIHSCaPOkPZcX5soiBvbaC21z9JIpQH177U02wvZWiBGySPVk0w+dF?=
 =?us-ascii?Q?0k4SjRveQzpQ53wezB0++5NOyLpSp0iY17l2gCZN6GGv2djNp3brPxpXz5Co?=
 =?us-ascii?Q?0T07rNMaLbq3oGLzXPq0uT4Kz6nABJWWJCtVpngbbYyroP/xMJM52GK1MAus?=
 =?us-ascii?Q?u3RJrQTewaIyIhF3WcHNp2lFZzL7p7/BDH0LQkJZme94tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0Lo3XBTeUcs2QXLAA3mA5oGBrMWws59BsAqu1oweJl1FsK/IIx+buKSVhhU?=
 =?us-ascii?Q?r5paCOvkwqW7CU8koJQcLCvmjzdEeRGzRKdeJUK/XlHKFf8u3FUBqug5HNVv?=
 =?us-ascii?Q?LcbUdjHuqzCh+0fGJh02pHXacfwbrwwQIwYrcun5mPSi8tbT8pJK51REKWzT?=
 =?us-ascii?Q?7DNGE036mbgnG0ejFH7Xlqfjwt7LB+p/MN5lIpMY77L4wjx4EfxgrIiTkvsc?=
 =?us-ascii?Q?aeSH4V6o3nvmBICyhW6CPh8TblB25bbXhtFhoJaD4WIcVl46xJqR+hPNt3DH?=
 =?us-ascii?Q?oumoVfvtH1p1mBYmgt/rAD3g4fZUtfucDIIluRNkleucs+v4lhbx3GgbwUz9?=
 =?us-ascii?Q?1sTsDXCetenHXj7kEFEkatMvcxJ7MCFKEfnK+xpyUQaTjucO1zwMJM6YaC7U?=
 =?us-ascii?Q?gwUCnzlb3nmKb4RHvsrvcevp0sdPZGi3vEg87jNr3gCSa8Ce7FNHbVcT/8qJ?=
 =?us-ascii?Q?CZKFTYrVHXR2McKKMpOau+AXRzqCu0J5cZOshBoLOUKv6ksBg7BOq6gvbRCo?=
 =?us-ascii?Q?RO+fDUOj/h4/auO4GvfvfoFJsdPNgUGH/bPlk5aDWMIXVnYgMJG+RtClMMUt?=
 =?us-ascii?Q?5oeOd2D38Kdv21am6W0Px4OYB5YiAF2QyJU9enk58Dv11Rx1XwHZd0hAN2mA?=
 =?us-ascii?Q?c9zKU1rwxTGkHrbiNRlz9/fhREK9sCXO5cobUDkqxHFnN4seY+BYLp3zZDZr?=
 =?us-ascii?Q?KkrlGbA6/IVRi9ps5xCXrd63Nmv/qkNuZJdp54its8Pg2u6ldVcF1EQ14ZqA?=
 =?us-ascii?Q?weCVjPMJaCMed1NAKC5qI0pDNRLrBKz5Fk35+cWSADuNhAS/XeY/FGD9trPT?=
 =?us-ascii?Q?sXiN8ZUbka7r7ikbDUrJNFdAL5ZpGgwdW6497PlKlCqZs6p6/EslSyPNEFnr?=
 =?us-ascii?Q?2Nep2ijdWMcv47VTpCD6zQUL64GXHskWtRAzRNimaZt3oMddZA76+vEkZGGz?=
 =?us-ascii?Q?cBpI0snIcad6VGcd9kfmPYUzNSHJ795davyrlt4fwISMrNhaVJkyxSm9O9vF?=
 =?us-ascii?Q?opXKTohU/NzVHQ/C5vJmQjYuFSlOGRi76g1D+fcGW5FZgeYRKUInmv7B9GNh?=
 =?us-ascii?Q?PM7V0002YZWD6UZ4Lm5lK0dT+1VhzgzXoWdvkkAsxoM3eQrigkEnevwJRCJ/?=
 =?us-ascii?Q?96fTwlPuRUOzgDE0mvCVAAPfa66LnkrkhoL8HlpMt8dBRxQpGqWlNT8WZwRG?=
 =?us-ascii?Q?iwTdIvOhLtWB9NzRVVHNTlDEdnjXjcTPbxMJXhqHHJKdjbyictYiVRmQOoMZ?=
 =?us-ascii?Q?hmfG421aBLMb3IMSRy8vrXP28lQyRqoCb1lpuefy0wIPjMZ7iru8iGnxi12I?=
 =?us-ascii?Q?wSi198GoxHDbXDnTdZmqwaJm9ndW4Xb+eBiHSUne3l40NoTow3MNlk2Krqm0?=
 =?us-ascii?Q?qjyYehHkeGuhK4ctUAQVSqsS2/FZGaRw7u7J+bMftbJ/gooKWZgDfz6pF0Ox?=
 =?us-ascii?Q?WxdEsd7Jog/H9vsnUrnoEpTAJmcx6jk4JiuhcI//UG8ZQErDxJ43qmqFkgUf?=
 =?us-ascii?Q?Aq0S13EruBASnpTuhMO8+ONWfunp08Z4Fsk65ZYQSPPNbF4rHRuZWtllfPoC?=
 =?us-ascii?Q?FogDv5cx1NvDi8RbG03ThCA2trpIbOz5+S/2yETE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0638df14-b62c-4766-02dc-08dcc5d1ed8e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:21:00.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tz5kX8YzpkYDk/TTrgSd+cjAsWa0GwYV+oR9SpHDgWPku3pAbg3G4Rj1Zss+37LF4iO3eQibxP6/1SPM2Ox+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

On Sun, Aug 25, 2024 at 01:16:37PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 21 2024 at 09:00, Yazen Ghannam wrote:
> > Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-core
> > banks. Each of these banks represents unique and separate hardware
> > located within the system. Each bank is managed by a single logical CPU;
> > they are not shared. Furthermore, the "CPU to MCA bank" assignment
> > cannot be modified at run time.
> >
> > The MCE subsystem supports run time CPU hotplug. Many vendors have
> > non-core MCA banks, so MCA settings are not cleared when a CPU is
> > offlined for these vendors.
> >
> > Even though the non-core MCA banks remain enabled, MCA errors will not
> > be handled (reported, cleared, etc.) on SMCA systems when the managing
> > CPU is offline.
> >
> > Check if a CPU manages non-core MCA banks and, if so, prevent it from
> > being taken offline.
> 
> Which in turn breaks hibernation and kexec...
>

Right, good point.

Maybe this change can apply only to a user-initiated (sysfs) case?

Thanks,
Yazen

