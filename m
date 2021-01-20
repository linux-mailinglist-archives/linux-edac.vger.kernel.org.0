Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44C2FD2CC
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jan 2021 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbhATOhB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jan 2021 09:37:01 -0500
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:4033
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390736AbhATOgs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 20 Jan 2021 09:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6X2ummt9LDfP8x83dhhvm9rIbUo1wcbD4JqR7pmLygt8hsmQtlGaom/6dnFKnL0tJpkI4JE772Bi2b8ln6wfG35P6PkrFvAdaXOF1ohykm5nB3VbsqtYjF70oU8Hldgj4PKjIv19ihKDgfeqH2eq5OOu/YY/zS02jaArLXgYScdl3+CeqJlV0z2rWO/I4HcEcGCvY0FmvQYe4TFeR64eoJwy/l43TfEtNesNRhMA9LAZ/qW0iE5Be5+D8i1/3YIsr7H4Py1tj1RyvomYLtUZW4Jt3ME3aRYorYkVyEVbOIUgwU7twW8t5JA+ZiesJgCUZASagL2sBBRCTGI3T7LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1F70Uc/YP0Bl31EE9NdVykITXmwatRqnLV5HtK6fI0=;
 b=IK/2LRO8jX9SjAcoa8ygauld2eeG+RQvu+aSkzyPxAEhHtfuU5OikHY8z4cK2fLg+Vx+L6fzY0nE9cC7ExifOMIqaGyQKKrLpRCjc8Dtf6atJzbgm5i5FYVh21Us0pZdaKCDii3HA6MEqYPU/eDaQNwmP4KOelOfG15W0YWWDwdjFY9Ar2yxWlVh9efyisaFz83QvsjmbGWXGGvs8QNP3vVJTmUz/fJIXmv021zijeJKR0sYaZMJMpHsdjsK+//3wuwMQk70ew5/CQSYIE0iC7uhAbxHoM7nwOTTNYeUfj29pb9n8b7Ux4zKg2MdAoU9nEpmP1lHJ1BKyoRR/dR/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1F70Uc/YP0Bl31EE9NdVykITXmwatRqnLV5HtK6fI0=;
 b=l7RV/d3ZhnFaQmrGVCtwrJVhgKlJ1zHeq4yFPINbdh98gpFDDYmVLDYV9TtGCM4S7kbagag7E14REepKI2+qR/T0ChWBxtUNlsDehqNnlFHYjPwWf1JUJ4xHhFx/pMR1312iF7EGA7WTer2Scxc8Pcs5YPKjb2P6hsjDDdH9pJw=
Authentication-Results: torlan.ru; dkim=none (message not signed)
 header.d=none;torlan.ru; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1378.namprd12.prod.outlook.com (2603:10b6:404:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 14:35:37 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::866:baa9:f17d:d6b4]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::866:baa9:f17d:d6b4%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 14:35:37 +0000
Date:   Wed, 20 Jan 2021 08:35:29 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     WGH <wgh@torlan.ru>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] EDAC/AMD64: Update scrub register addresses for newer
 models
Message-ID: <20210120143529.GA1385775@yaz-nikka.amd.com>
References: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
 <f171c29f-5c89-683c-8cf2-399c9af5153e@torlan.ru>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f171c29f-5c89-683c-8cf2-399c9af5153e@torlan.ru>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:610:5b::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by CH2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:610:5b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Wed, 20 Jan 2021 14:35:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61853c7c-eb0c-4051-dfc5-08d8bd50a6d7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13784095FEF58B642B54A47CF8A29@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5oSMG8hSIyJrqJC/5hKvX9bJTTsaCO5d0CAGgwGURWBkcPDbHtSuzHNKQCVl72sGXZnPsGOeNJO9WIH/CM6JkyZIzSqDhgef3ToAgjYANM9TsG2BpT0NM7wepE6IrwiW13rjFQUjdkFdAjfzPnr36bacGbZm+rlBcgpNCsrh0/A5YNcoKDEPWCMu6UT3h3OZjivWrJY8XalvvkoDouyYy5lqf7hGcCua+hWe+bSPHeBL76Z5xGKBQiNOKU622vUsFINr8LRyTI1Sb1B6jz5yEfnBI25/spNVtbCjN88reJD0TScUL7zAP8EOQ8cWGsE8S5xDojCWDczR3VuoliOz5cx6GFXMHIhUXjm7GjOcah28pFKwyBttR+84IN1VanKbcPGgj980eIesuD/pXn/klEqBUACMH5s5UamDPTHhnD8JfX76gfvcmD/VVFOB5RA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(186003)(53546011)(1076003)(26005)(6916009)(8936002)(8676002)(2906002)(44832011)(956004)(316002)(16526019)(5660300002)(83380400001)(55016002)(66556008)(478600001)(4326008)(52116002)(7696005)(66476007)(66946007)(33656002)(6666004)(86362001)(170073001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?/eWT+K7MOJs/qcqcM9dFx5UZ+7tHGqScL6ek2UM1HeLzi6YMVdFmu/ASI0?=
 =?iso-8859-1?Q?Ax1geUBRywfTFcJWJo4YNYS8+gwowO6UwFRe/Q+ZKMxnSnUstQiZoU7ObR?=
 =?iso-8859-1?Q?m9gIU95TGTfQkhqRyRAe2brbAc5iA1/AfFfKr3PgujT2vfUiSQLbPWVDrs?=
 =?iso-8859-1?Q?3ZUxfX9/JdMiPlQJqUV77Y9bhjZZyoLbXphq+D6gHif2JZSo569tiSN6rW?=
 =?iso-8859-1?Q?p2067ynC3vbk6MV866VOjflLZbavMJ2gqEChZiFQtTAurkPsp/cK+4804Z?=
 =?iso-8859-1?Q?SWWnArEkmUDIE1CgVv6hDhboPwR2L00pxVVXd0PviceizMIpBYZm/Js11s?=
 =?iso-8859-1?Q?lvoZJaP/3Nmyv1h7nXajbhA+Umwz/R44jgvBm4MO4TGR8OZSi7QnF5ptF8?=
 =?iso-8859-1?Q?mvxIwsTMyQdnpJWZRv0c04IZar4C5VpaHbLGkASp9SfqIsnFatMd4fJ7zu?=
 =?iso-8859-1?Q?jo3Ax9Kr392vwZOGI2cwkq6JgJcULwyKtuBqKBdxIVGhuocaRnM8LqkKDf?=
 =?iso-8859-1?Q?PNLsRwzuEErmESJRqO28ExwOaygEhK0c8Iqn4WHKRG3dV5jVIzN3R6AyJ0?=
 =?iso-8859-1?Q?bIPvtw5dQ8nvZPMtN90XslwTc235zjjGgVMm5yd5Ickoojst5mpndennc7?=
 =?iso-8859-1?Q?ausc0voiRh7PeJ/9aLXUObUcE4CwCiU1uc7rmYhtFRFzjPYUBtEdMJ5T4w?=
 =?iso-8859-1?Q?0cGMfhtFgSCde2Rf3J5N7TPp0J81wPS8mycBr6xL/rCwFyt50an606/szB?=
 =?iso-8859-1?Q?6RyVqyFJmv6902iZ2wZJpyyHSsKQ5XyeHSwqksQCDjyPrs9QOKZ3LWkACT?=
 =?iso-8859-1?Q?3xPCg2DIAcbOL7m0vOvRj0ULLOpal8OOQBWWfdhL1eoQYdDjhMJQqqiYu7?=
 =?iso-8859-1?Q?S4Ah2PJVUAGzi8ojRmJPkbVkCmmmMPXAUJTiOZ/fTJW+NqYiAJrbg+/2ee?=
 =?iso-8859-1?Q?ZoGj6s1ZsA7G9b0vusD/Nj9stoK3nIjUzWSlNHpw8D7n9AWBfqaEplZX0K?=
 =?iso-8859-1?Q?hHwKMoNh+xN+3g6MQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61853c7c-eb0c-4051-dfc5-08d8bd50a6d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 14:35:36.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URTbP4HD+H4ZSVWZCYp6ykzvrlyX7iwGPVDqr21B6L/VIgiwa7sJGQtdA23v/HB+mLjqa9cYrDO0KDnPFpy8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 18, 2021 at 04:30:58AM +0300, WGH wrote:
> On 16/01/2021 17:33, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > The Family 17h scrubber registers moved to different offset starting
> > with Model 30h. The new register offsets are used for all currently
> > available models since then.
> >
> > Use the new register addresses as the defaults.
> >
> > Set the proper scrub register addresses during module init for older
> > models.
> 
> So I tested the patch on my machine (AMD Ryzen 9 3900XT on ASRock B550 Extreme4 motherboard, Linux 5.10.7).
> 
> The /sys/devices/system/edac/mc/mc0/sdram_scrub_rate value seems to be stuck at 12284069 right after the boot, and does not change.
> Writes to the file do not report any errors.
> 
> dmesg:
> 
> [    0.549451] EDAC MC: Ver: 3.0.0
> [    0.817576] EDAC amd64: F17h_M70h detected (node 0).
> [    0.818159] EDAC amd64: Node 0: DRAM ECC enabled.
> [    0.818717] EDAC amd64: MCT channel count: 2
> [    0.819324] EDAC MC0: Giving out device to module amd64_edac controller F17h_M70h: DEV 0000:00:18.3 (INTERRUPT)
> [    0.819909] EDAC MC: UMC0 chip selects:
> [    0.819910] EDAC amd64: MC: 0: 16384MB 1: 16384MB
> [    0.820488] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [    0.821067] EDAC MC: UMC1 chip selects:
> [    0.821067] EDAC amd64: MC: 0: 16384MB 1: 16384MB
> [    0.821630] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [    0.822187] EDAC amd64: using x16 syndromes.
> [    0.822739] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
> [    0.823314] AMD64 EDAC driver v3.5.0
> 
>

Thanks for testing. I'll try to find a similar system and check it out.

Thanks,
Yazen
