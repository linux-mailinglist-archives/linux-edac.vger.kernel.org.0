Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0C477C5E
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhLPTV6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 14:21:58 -0500
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:42752
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240938AbhLPTV6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 14:21:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPXItQ6Qm5YCxP0vhCCPOlJ7Za+Ax/+amr9YoYaPRSbJuX5F/sL07dsYsKg04Jr2VChRoUrmMzwnBpub0EILEEdfJJR5rPfpvU/JQy5veisTWwBT/kz0YwqPKIhmrU22eafl8W7uoGdUO0nwvSQUlZ5/X8K2eYna4kS2g/gStD/ZA0hS/eR0QbAMJNmWBe7ah2ylUSZjRX6c2OnorV5ve6+Lb/QKs74inyXs873PvILqcPt2PZcnbuCHVu1IO7b+YTPnppThSjpSCeQvRtK32+RxeqmXnihZymxnGAN7rhe0msAoeOXo8s4+XtDsPmwFBXObhNsMqGHZTCyV0YmDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss0MyzX9js3vO4SFDOYW8h9HV5LqwVexkJZIcwLmMYc=;
 b=dE2Dov4II9jefPwidMZJ3PpBaO0PKDK10oyUJJkXhSNwffpgQyhC36AEQ4onU7wIRDZXImlIb7kpG73cU7S6ympTlPNtZD3iTsxcRr9BynIsEsBmYSPxp103KQHWBXF6OJUk6sXZhDBst7Sm1LXb6Y2zNN10A3BrlG/5dtekN8pVrFPeimZW3FS01WMXSwnEhMoAm3YpuT3N3UXdwQY2b9PuB9uoKDHa0c39yebxnjf6XAROH6IySszY/AVKpkSPRTEScOE4oFZ4UcXvBo/owDfrrYIzMzsKWN0weli99BZcyP0cWLp1LZSPl08vjv3kLphJq7z4B0sgEOa90DHrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss0MyzX9js3vO4SFDOYW8h9HV5LqwVexkJZIcwLmMYc=;
 b=uCinHIJcbk8JnR8e6WxG/8PelMAOHN1rYbG3NaRmElRSrOAxUwujOj1y2EGqrXdOYh28xgoD1jGCFJrKW3oZQOsHROSMWFVhg8b8W6UODaBkt/onVcZC8akK3eXgQyqCs44IztijLRCj3Z69JRUdw345nNrsElThCmBWj5ZzW2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 16 Dec
 2021 19:21:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 19:21:55 +0000
Date:   Thu, 16 Dec 2021 19:21:47 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     William Roche <william.roche@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 2/2] EDAC/amd64: Add new register offset support and
 related changes
Message-ID: <YbuRy5I12ubxxM3p@yaz-ubuntu>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-3-yazen.ghannam@amd.com>
 <d327bbfe-a3c0-9b26-569d-43e17dba126d@oracle.com>
 <Ybou1VTJ8oced4Ge@zn.tnic>
 <YbtfcUmWAFDWMG9w@yaz-ubuntu>
 <cd5fb58d-1529-6c05-e49d-ec36f0337483@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd5fb58d-1529-6c05-e49d-ec36f0337483@oracle.com>
X-ClientProxiedBy: CH2PR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:610:55::39) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c4b370-2d2c-4a28-ad17-08d9c0c9527b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB317171FF6EE7EF8D20D65406F8779@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRPEz+chZz65W77XzjkSPtkB0ZBgfiuKeYS8z41h83+UbkBoKqlbl0+4fUDJaDpZdKJhtMSxAt8szikeGBFG/EYVtYzPUcm8GWaViuWMKTAEsGHgdp4AqHuHAplC/My53c0tMKlGg5UwJZ57EdBSpYyLKOtge3MWOIQJ695ov3du1Hvet3j2PuLJUeK3k26an9nRCLzZrrwXlI22y52+5qeIjExuK4OwaR0zh2jvpFl7T581xP3Lbk/lzOmHdumw79vla0y9Nd7oUf6znoMc0+/5ez8+NNlPoIx4CqGjl6ArQ97f01f0PbTnL/PZInerKcUCSjOubPTWz2emxiVID1ITX+FoCdjyvHbuRkmNUkVd+Rufr1nDJg8mRursAm6zmXl15jzc03DuyDJKqk6Dai3IshwQ5fHbxUfki9FYHBeQoGHlRVWKgVOxBjbyEhyAJQENvx7DcuJUQyEaBjgihFI/7dLvk+/mnE2BRgAf/jTocQpNC002dSJzccJMNKUR1ffyjJQuYiq4W0e7rv/HZ8JY5aXl2iCqpEiob+tU636nCxHdZauDibUHuoVyE+3i6glh+OiSRGhKTrK7QY40xVxGcPeWzmwzh11X9qETFIVBDDwItI5cCclSSGw3D8GADFcQgesxPW+nF/4+AXVpYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(66556008)(9686003)(4744005)(66476007)(5660300002)(2906002)(508600001)(44832011)(6666004)(86362001)(6512007)(66946007)(316002)(26005)(186003)(8676002)(6916009)(6506007)(8936002)(4326008)(38100700002)(33716001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hV/CoTOgraDUlVd31Tz6dvRJGlClT0Tct8Q4NMVgYFm/oJtPmymf99XNXg?=
 =?iso-8859-1?Q?BuLe7sh7yDiknMfeksUMCOIR/BHY5HakLgnvXHlfcURiM1t1w9c1PNblvQ?=
 =?iso-8859-1?Q?XThm74afXwFU5EOgGU07KBtQjriOaMl98lLuhufDt2+S+nH+CKq/plEVBv?=
 =?iso-8859-1?Q?8T7ohYfxBkxvkl3Mzw41c/nJothMIctGfuApNAuN14T+QPTF+sOwXLz/nk?=
 =?iso-8859-1?Q?qViI2jy99QZu1F2aVcT7sJdx52JWO7jNhIQhKw58M+O3/cc3h1PvIE2IzB?=
 =?iso-8859-1?Q?a2fCD5kMfVgEwT/UPdLXTTRNYgejThY03CCuqju3Bs0TeDsGph25dO7U+M?=
 =?iso-8859-1?Q?RPMVILllMs99a6gTNwki+IJmphM5ej9cJGKCK8Ve73crSr+qfMafUbgM08?=
 =?iso-8859-1?Q?pCTCGtcGEwvn5z2rv56f6AJDgh7zi88TYO9ehCqMVOEe05/TP4HWE3eoHH?=
 =?iso-8859-1?Q?lXAvKrIKjPY29dyhGMNVfYFXRxwtiKjenmhbYQtr3U33RwN9OTg7Ex3yyp?=
 =?iso-8859-1?Q?VRy1fYXgnsM8tCHjq5g0e1wuYTjeA8eAqGYlmhe8GLkksM6k3HfaUBY0o7?=
 =?iso-8859-1?Q?dm4kENyhKAJZ54cpOqBpAaCEBYjXxc3Xo/aQX1e6chO4Xmi+6GuR1M4zjF?=
 =?iso-8859-1?Q?sznFIeZ6HwLu1trkawhnkkIcTyqwh/+mvFSF5sTNpA5NYOhWaRGqztILf3?=
 =?iso-8859-1?Q?RDPznxQR3Ae3+8LEFkRYESYIOpIsK/x4wJfek/s1EYtdX5xD1HRZTkDKtC?=
 =?iso-8859-1?Q?Oy1UgeB2YRBFm2IVOqh+R5n6xMrC7ii9FdMCnQhF7byyTLgjttXgXivnXr?=
 =?iso-8859-1?Q?U2l4EKY2JvEwT8enVRz70sbx2FGk2nXsy9kAkPkkIIO/NMXk74ZsHPEGKr?=
 =?iso-8859-1?Q?+cgeIlpO7lmQgboVI5B+4emfq/2M6ztT6T3w31HoxQTREblIARUOk/MBhe?=
 =?iso-8859-1?Q?1m6AQRTZnNzptIyohIGRs0+N8aXZvzJWNHmYP6qNLJZyhgMg11mGIEoK8x?=
 =?iso-8859-1?Q?Txxv6dkGodOVUQjAbk7xCoM2ASqEHZUqyXuUgf1cIvx651VoLFkg8J3mOM?=
 =?iso-8859-1?Q?XO6NY+KwgcxJcV7RAHBAflZHiuaY4+JV0vf/lijLubZDPv+AZp83JUlbOw?=
 =?iso-8859-1?Q?woEOr4a4YHjfw2CLbY2HHX70b3ysScZNVj8SF0QLNkfV0/LktQQbj/lIni?=
 =?iso-8859-1?Q?9H9aIA/5j90NyZgFl1q9ljpsq8VZoeVm879cnYg0JrvuerLWUXMyz4HLBQ?=
 =?iso-8859-1?Q?+ilNPQT3nut4Y+jiQ6Gi4APNZL8S6pw7yFbB2Pr7OzJe2MlHa079AP9OWr?=
 =?iso-8859-1?Q?Mcg+ZccfOdsBdP77/v/2eq+8sIwThOYl6Q1Llzn8/xmwy5hsmYofXOZ7kn?=
 =?iso-8859-1?Q?hkqrAiymuZybYnZixzCDnICjiFnknEcZ+Qcd6fnG1wFbQ6YAc9crAiyoES?=
 =?iso-8859-1?Q?xiCVFW+C4E4q9bGCKO0KPqMxtiqdfPLqf70dxdTEUYmoMK+YVP5uATgp4w?=
 =?iso-8859-1?Q?QeTwSEnFjKRID+G8CFtAHcutgVjQtw6VBpt9top5yp30+GfYC7BZVqo/s0?=
 =?iso-8859-1?Q?M8u3n1Dov/Q8+56hlEqQgFgEAa/tEtBCXDjtZkWsBY2MTi922QjGRoluzm?=
 =?iso-8859-1?Q?/axapuUHE1E7zxJTZpQLLRgSiFNaW0RBKZ6IALd1w5RZW6ha4axNQe1sJZ?=
 =?iso-8859-1?Q?lUTgO69fQLr0zxzPwr0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c4b370-2d2c-4a28-ad17-08d9c0c9527b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:21:55.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trHGvZzP7oBodWLZ7ouxGkb+oiIFmFpLFIf19LEaQmQfB0159OmdHAaqMk/tJeblRqKupw4UnjSmm3PacE7O9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 16, 2021 at 07:43:55PM +0100, William Roche wrote:
...
> From what I understand, future systems would still support the same number
> of dimms per UMC (2), the same number of Chip Select (2 per dimm), the only
> thing that changes is the number of Address Mask registers (going from 2 per
> UMC  to  4 per UMC).
> 
> So I'm confused, we deduce 'dimm' from csrow_nr, which would be in fact the
> Chip Select *masks* number (cs_mask_nr from the dbam_to_cs signature in
> struct low_ops), so why are we saying and dimm=csrow_nr in the case of the
> new layout, but dimm = csrow_nr / 2 in the case on the standard layout ?
> 
> Should we indicate what this 'dimm' value really is ?
> 
> Sorry if I'm missing something very obvious here.
>

That's fair. I can rework the patch to explicitly differentiate between "dimm"
and "cs_mask_nr" here.

I think this would resolve an issue in a later debug print statement that
includes the csrow_nr and dimm.

Thanks,
Yazen 
