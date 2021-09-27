Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67F2419E66
	for <lists+linux-edac@lfdr.de>; Mon, 27 Sep 2021 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhI0Siy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Sep 2021 14:38:54 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:62113
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236174AbhI0Siy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Sep 2021 14:38:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7j8IHNQ5jwmd3W4hXqSIytlcHenf+hEkjmYiO1sblR+7nabr2TFeUwvJWkn6294QuSRjg2s9b3khe81GMh/0P2fUpvCAky9+XjX6qwcGwNsavWUqvFHbCIWTP1S3e5VtJYpQzFPxZYXaBQq9YgOwiqLuGzkbMdBwB7jkhAiuK0HisCwWtipUpjRvm1yCwg9wZBEi3Omax7PSLlCWSZn0QBsD96iQ69At+N+iNRWENzKeu4TBwuoeD+BCaepCx17jO7SpqIz70vH8DQ34i+pH6s2BaBrPAnBWhrnzXSDqTv/iH20CRLmfcjId/sFxpzXz2iNYox6oWpvxJ/nS/O5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hCHav+kR9GZr6MSqjPozgamqzsn3xl+RWMahUMaCMCE=;
 b=e1ENKm2wLFxhSUp+ri6KDbzPfTV8KsA0ah0fQFfV4lutbm2ynQzLhVnUS6rz0fvghU91RuZ3Z39a/8cTDoluMwykaM2yOEeWXmbbv5yzHy13gKijVb2PxVIb/gnOLv6TcRkzSfp/ix7kCzC2Ty4wWZ6jf4E6fK1WfOHiAej5ubG/81iVUjQk1nfNZoJrZWDUV+Kc2WagOFu/PVskynzo/pltBEtc7ubRjnNIItfpfdDpaX7BJPH5U6Em/MmH5y6OfYlJ1YfFcxR901KDzenIBYFKCrRHYrsIOk+MNyrlAt/pI0HaQgQOsULiRlXrhJikVrn2KaE1j95Ck1Sdt731HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCHav+kR9GZr6MSqjPozgamqzsn3xl+RWMahUMaCMCE=;
 b=Q9zog1fJ6g+HyO2rUS5gaKiqC5EknQavc3ID5sw3edOxKii7OZpThH8EIYedTcQbwQbC+3KcF09G0CxDcjrKfAqrQuUgFhXs9YzeNUBOqMuRppd0UC1deir3/MuhuUpGCshf/CDg8YshdlgJagqb+Jm4uQCHWPRsVrv1xnY81s0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1811.namprd12.prod.outlook.com (2603:10b6:404:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 18:37:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 18:37:14 +0000
Date:   Mon, 27 Sep 2021 18:37:05 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YVIPUa6vaax7DVyE@yaz-ubuntu>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YUy4CdcUWJzQfM4N@yaz-ubuntu>
 <YUzD9wxtV411S8TC@zn.tnic>
 <YU4rAigWIh8g6iOl@yaz-ubuntu>
 <YU8GGSrQSbAZPz4z@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU8GGSrQSbAZPz4z@zn.tnic>
X-ClientProxiedBy: BN8PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:408:80::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN8PR15CA0041.namprd15.prod.outlook.com (2603:10b6:408:80::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Mon, 27 Sep 2021 18:37:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 681876d6-1efa-4549-19dd-08d981e5d308
X-MS-TrafficTypeDiagnostic: BN6PR12MB1811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1811B2D96BC704800BF733A5F8A79@BN6PR12MB1811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+qr1fd5FfhtFuJ6iQ1xeh1EHoeo3d2+Sc0KDwt2mBOdZmy5Q2ICsAIFLH4SS3NdYFm1lAGImBo/TPIEm0VG/gd5wAmxEbw8I3kWKD2V7tC1AXBBgDvuGMFjYeXzK4RF/ZgrOCoFCWerBdqQH5R8oYxFAizfYSnQkljYjk8L8N7ihsTPkqzO3s3Q9EeKoOgXFlC/Eiju4XmrPDo4Vr9H2+UI9f78JNoMOLgfGJBSkrd8rEU0qoXsjuz4yBaD9GFOptsBi9WWgUMKknV6ZTkuIczpEA1+AVrTC18SaDJ9/6/iymEVvdqo5nirOC+BxM7uRXQrSvdx1MHmJGI3utnWksuMqPjmq5WVMu82N6oH6JjKhcJxv/+OGqKuwB7fW74MMPgqqt0Tbc74ksvcWaxzZfo0thzibgNyEqlwJzm0o0db/Opi/sYngVq4qmIjW46JSdgnm6Zsg3WnXXgUl+RCGmwzgjevdzguoebweX9kZD4kKblIbYNzOIBRYZ1kelkQ+n17tAICfgq+p2OGykNiymvcxjvJwhyh8ZMIsBNGn5uQKimukLz/QJYTc42uYFOpMnmWp1sdGgQLrxho545fHzxoWwZ/Kw9s8Ki2v93AMilH2sorsZpZ9Kg4xMGatQD3VPL4K2dAOoUM76UUqosLDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(44832011)(33716001)(956004)(6916009)(54906003)(66476007)(508600001)(66556008)(2906002)(4326008)(8676002)(8936002)(86362001)(55016002)(38100700002)(9686003)(316002)(26005)(6666004)(5660300002)(6496006)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwQbcLS+OqzIl9qdsS9tzWM33I4db4kBcH6wUzzMA0UGr4pSvBCvGyd8/HQw?=
 =?us-ascii?Q?UhM+D/MAww2YZM1NHkpSKROnpgJgQBX94VlUTlT1TvlruN6WZDrsKR1/LcCH?=
 =?us-ascii?Q?7kvvO5Rgx+Tt1vxGfyoKzzJxxNc5IpPpcS7mW0y4hAZz+B3IwW23hVCJKp4P?=
 =?us-ascii?Q?jO1+NK/kgjjFCDv+kWCXj9lSoZRm1JoG63dAJJjpjtIDOk43v9XIoygw/Zu8?=
 =?us-ascii?Q?sGrhkOTiLiYm+jE72R8GfahL8elyVWMhlXi2pvVPWEL9ZqS0RF7To/GrYStD?=
 =?us-ascii?Q?rM2O5vhoJz5vum3q1CmTB6UTjtj9Y8mwjqkxqcBEGVS6i6mfYp8WKWDWl+jB?=
 =?us-ascii?Q?phc41ypLnQTH+/9c9vJhDyAoMHgLVdeGagap46w550XJJZtNBUoTZZpF4fvh?=
 =?us-ascii?Q?Mb2f1yWoJH4Hq3YhKrDmcR14Fnj6FM9+0tKFyICvx3HUMzCcLLC3b2ebJug/?=
 =?us-ascii?Q?WI7grvycxO7MJ3RUAa4nHjfnhwIhCRq0OxocibQSk6rAZK2hVgS0C8B5xzdg?=
 =?us-ascii?Q?cPHHHmnRewFfLyt14jN1P3VQ0Z1QfPwwlxPOc+tFY4rwwmaALDZqHINpKx6Q?=
 =?us-ascii?Q?2odHrqU3+sRCvuUHR/PrDxifZitAu766jVlRh+LiebQiizBxEjuEg2KBxVuk?=
 =?us-ascii?Q?KoKD1nUd4KqaM+ZjRnQAIOVgSYb35I+B9TcpqbIBZOyhXrTBO9frl0iAic82?=
 =?us-ascii?Q?hIpqPHNi9Tkfl4xDLYyXELawauCcfgLkAef5zF3ii1USk+nNe55OpzM5DECi?=
 =?us-ascii?Q?viKtNtJjcGjW8gJzGG7I82xXzu133xR3UzUAO29ySrPshcbk76BSbAAQcULL?=
 =?us-ascii?Q?Rzsg0XdYpXLX0x8xonRNvsAH/MU7mol5GAwGdUIVBrZDjqXSJN9/gh5cfNDe?=
 =?us-ascii?Q?sdva1qUnyH33SHm8SGa1Z7fgqSkgFtWWfXwbJWOn+5Qqx3PJcRE72j8PHIWo?=
 =?us-ascii?Q?QGVWlmF3yNOPACfMeLGzwipum/ln6PeuHcy5JZsJahHsgdR4YLHCmJqLbAVb?=
 =?us-ascii?Q?0qXasFO1U9turWeqAzlWfKW3qnIDyOml43BSBmbBrUIXWdzA+rDXtQecic7e?=
 =?us-ascii?Q?57yl5zMj9DolqIAWcnqn7gEOxYotCAcDViwQl1ylfuKlUDeER8525kZn3jrz?=
 =?us-ascii?Q?At0o5vG2CyBwAGPZQXaG+COW6c9eH4p9C4eIl4RY3vR3HHsBijRxXe8Ohf6/?=
 =?us-ascii?Q?FVT2WMspIJa54kCQIAM5GTm1cZ0mYk73bngrfXlzuErASJjqoyJMBSwpaSBh?=
 =?us-ascii?Q?q3uErJG2wJ4bszSgb72aiscFqmmfyOg518og6AUky7McHkp3m6lqp4L0eGbZ?=
 =?us-ascii?Q?vog3vayrt7oZLAt+MxcdnJPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681876d6-1efa-4549-19dd-08d981e5d308
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 18:37:14.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqUIFbAt4k/NOL4FCViy7HQ67noAt04eFK6GbCcjvb8xo8GbZM1IJwtnfXiS3NdjCSEwUtbCwUIBYnEy/Et+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1811
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Sep 25, 2021 at 01:20:57PM +0200, Borislav Petkov wrote:
> On Fri, Sep 24, 2021 at 07:46:10PM +0000, Yazen Ghannam wrote:
> > I agree with you in general. But this device isn't really a GPU. And
> > users of this device seem to want to count *every* error, at least for
> > now.
> 
> Aha, so something accelerator-y where they do general purpose computation.
> 
> So what's the big picture here: they count all the errors and when they
> reach a certain amount, they decide to replace the GPUs just in case?
> 
> Or wait until they become uncorrectable? But then it doesn't matter
> because we will handle it properly by excluding the VRAM range from
> further use.
> 
> Or do they wanna see *when* they had the correctable errors so that they
> can restart the computation, just in case.
> 
> Dunno, it would be a lot helpful if we had some RAS strategy for those
> things...
>

I completely agree. The system integrators have their own policies for error
tracking, part replacement, etc. I expect they'll propose kernel changes if
they want any. Though I think general strategies will become apparent once
these sort of devices are in wider use.

Thanks,
Yazen
