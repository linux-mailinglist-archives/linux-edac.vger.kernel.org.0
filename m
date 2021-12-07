Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1346C0B3
	for <lists+linux-edac@lfdr.de>; Tue,  7 Dec 2021 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhLGQce (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Dec 2021 11:32:34 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:58190
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhLGQcd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Dec 2021 11:32:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7oVN5NmxO5boVgkw//ea+gqkC1gizVi74sRhlo87rAaoYGbYx6DzU/D8bl+TnIJE23FSOsqwPOpx+B6MGKXlB2isAeZkb/TyQMOkQTxnsoToTMwFibl8ixz1JeY3/rh9cv1/goYbqVp0YGck4YhLiqgLHXLH+e8mPqqi8lTPuBgQPlQFWEtyMElJqEsChhkxdGMGe2tyu5iIH/3qmUDoVJANCf9umckB3XE4AXARo6jZI654tZXVTcwcceCjIb0cO26wHTe/LCrwrRPaHBlYESaF9DAq2IPTpd29QfzyNraHZJZYJh3DhoShQrMRBMG+s66HVg9z5srlpmypnanIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdOlSMgUj3qk+tBxpNvzkMhVXlrHK4W3wV2x0P36q4Q=;
 b=UHfBMY751dkiDBw/UfCvbMJvFBNOy8Mq/rPsBc9vuSE0y64PbcKjEugN7rYjw8brY4FKpvYnqaiTvcIeZoyFGSK89ypO6zmv5NfaDjYIGyZDEKTRqUX+vTvw6K7DPRS4FXWj+e5hUorJqaa0y4LYOYVFmYkvYmGoLQb4O8lIr4lFaULlMln6gluJZhGmRYyIdm40BivPFAJbB5bSpR9femTxiRZtSYxO+biEq6j02cncWpY48EFNpOioaLtQvpiJdB+Lv9Sr5SyCCJElDM34jsQGatVjkAzDUqvkzqEHNu9thuvegOSf1U7z2sCdeZS66sztwt65sij9w0xDbhEPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdOlSMgUj3qk+tBxpNvzkMhVXlrHK4W3wV2x0P36q4Q=;
 b=jcbpwvkpw8C/cSHBdcHk0tjtAaCXh1rRV+LSSPuLeDuluI5Sme+gXdcLk5UpP0QEHrJIzptIQlprxgTLwBIgZ/sNKEN4RetAJ0U5viPDCXo3u/EgfTzy6ihmM9mWugO7WQIyeZRJshz9BJ2G0wkFzIh2egki1KkTO094pmAIivw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3170.namprd12.prod.outlook.com (2603:10b6:408:98::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 16:28:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dca6:dd72:888a:9db6]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dca6:dd72:888a:9db6%5]) with mapi id 15.20.4755.023; Tue, 7 Dec 2021
 16:28:51 +0000
Date:   Tue, 7 Dec 2021 16:28:42 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mukul.joshi@amd.com,
        alexander.deucher@amd.com, william.roche@oracle.com
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Provide an "Unknown" MCA bank type
Message-ID: <Ya+LukojuewlomeF@yaz-ubuntu>
References: <20211203020017.728440-1-yazen.ghannam@amd.com>
 <20211203020017.728440-2-yazen.ghannam@amd.com>
 <YaqXiVjNLINxwz8G@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaqXiVjNLINxwz8G@zn.tnic>
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 16:28:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa17ca99-7fc1-4b6e-eefe-08d9b99ea718
X-MS-TrafficTypeDiagnostic: BN8PR12MB3170:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3170DA354857C060BBB32189F86E9@BN8PR12MB3170.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 834EUNe/CGWlCoom8GL2csfWrB3Kwk4AkA1Jz+4fz++5UHSCpYbSDzNUTuEStxjVZSDo9CGxFZ+r7iSxXRt4ZvLQ4IHk3VpseBBAfxjOp4MaUOX5sFG2qhH55+3dHioneCGAajHKJMANgCLV68S5Va9TrbeENLWssMZs9xrrH6j2g0bCKXijmz/9MwGImVIG5MKaCKAjHyZME8SY/zdz3nQlsapXmqTMbYAxNYoWq3crwGLcuD0v0Tg1JcS09SAXi21oDatsP9RC1leiNtMWiLQQf2aw1fyMC9hYjSasSLLGWMU3XMY3XFbxbfc1bX8Lq3siEbMlAtFgfJNCnX4+UJdfCDybqgOaaH9zOFSckJPAdBMprxClzoCRa/nzd3pTx6vHa8UxUT65yw7KcEySSV3L4B+6byfQeY0jUBQbhemxELYJ0y1dh9Rzz/DB3mCNKt4G7bYBVwUROmv44LPu2TJpTNFOfljQryv6Sd7L35EqF68aj4AJmcEo05GtG2rS5zPHU5qcLvOwAMJT0x22vFxfAk6wNxQTweuqt6QzJ4eKP+aGpO27QVqBdE2JhTnkfvEBBuWtyTosX/Cg0mQt5iiF8ox6OGEUXAcPr4x1qiYwvNT9hul7WFZVE58pZclewatYWhhoh+HNjPd2QAoxm9lE0g+iZFb9pOQf2XqDpXQozObB1bt6P+WhHQ+opZ45M/lcHdNdQU6HKSmlRFzpQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(55016003)(956004)(2906002)(6916009)(6666004)(8936002)(86362001)(15650500001)(66946007)(9686003)(4326008)(508600001)(5660300002)(33716001)(186003)(6496006)(38100700002)(83380400001)(26005)(66476007)(44832011)(316002)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFcxN3d4cWQ2VmU5K1VXdndIb2VJaHkvQXRZbDFaRllBcU1UWS94SmNzQ2Y2?=
 =?utf-8?B?Q0crUkRlZ085bU1FaEg5NjBVcXJrZE5sWHNIbnVGdGFUTXd6Uncwek5LcUVE?=
 =?utf-8?B?UXB2NEQvRVhoa3I3ZHk0MFMwZklwdk93OVdyZWxneEpMV3hiTy9WMVVOd2Rr?=
 =?utf-8?B?VUx3VVV0UnlPZmx5VlFUQXJ3Y2tRUVNZVStqMVdYWXVKbTAzN0lGUlZKMDB0?=
 =?utf-8?B?bGNjTmZxRmczOHdvdk15QVIwU2VNZ0VHcUpqb0dxOGcyUmFtUFpkUnJJUnRi?=
 =?utf-8?B?ZTA1VXphYzhCamJOaUdqYkllczBvcDJaTi8zc3BZWlRTSnU2ak0wdWFQdXRD?=
 =?utf-8?B?Z21wQW1TcG5sOFZROWErTHRjcXc4SDJvR3o4dXUyNzNieWRCQ1Fnd2dFRUNC?=
 =?utf-8?B?S3BNUlVZTkZLS3VtTFRFaUJkSk8wUmpFV1RNci93ZTdaaXRPaEV0VGF0OXA5?=
 =?utf-8?B?MTBuUVU5VlFzTVgrbjlBN3hFVTM2aGZzVTBUTHl0Y1M1TEcyeFlIb0xXenE5?=
 =?utf-8?B?UVl4dm5Ta001YzFBVjRUMjlOWS9jSm01cWo3ektaTGFOOVVoOVBFZlVVYnBT?=
 =?utf-8?B?MHREZUI0UkZxTjFvbkhVY3hTSzhYeEYyUnNLdGxQNVBpVUV2emVSdDJ6NTla?=
 =?utf-8?B?SkhJN3d5ek9sSlByZGtHR3QrVXE3UjRwVFd3WnNvZGd4VndoNis5UlJUMDFh?=
 =?utf-8?B?SkFyS2ozZlRUK3d3aXJuWnpUQUF5Y09jbk8xNUUvcjdIaFhkKzZhM3c0WHBz?=
 =?utf-8?B?ZG9LcUhhSWs1K1VITi9zQ3RET3ErcVVxM1hpeWYxc25CZVZzWUhMb3FHM25l?=
 =?utf-8?B?NWVQSldWR3ErR0VjaGR6aldob2NVWk5TYkJCcGF1K2lLYTlDRmxrclBQYW9D?=
 =?utf-8?B?a1VIb1h3NFNhMmhQdy84ZFpNZ3JNdEdJbmxlajByT2xpOERPd1A0N3p5TDVV?=
 =?utf-8?B?ZitwclkwSjJjZ3V5Q2oxbGV4eVBiWHZpZmthanlBMFZNalJ0RFExZzhNOVRC?=
 =?utf-8?B?alFWR3Z4MmNxeXJEMmhpaTVjQ1NRUFh2Sys1b2NuNXNNYTZ4WDlMb04xdVRZ?=
 =?utf-8?B?VXdEcHVld1ZSSjIyZDNvVUtsOFcxZUUvWEtoWGREWCtGZzg3NEZDc1hMa2Jr?=
 =?utf-8?B?T1NJNkprbGN4K0J4ME5EVzNjUXZCY092ZGFUeEpVUnhISzNYeHBzVlJFTlZp?=
 =?utf-8?B?QzViSzVrNXlxYUJhb3hOQTB2N2szZGtiVHRrZlp1QzkzMWJQWTNUQVoyUGFl?=
 =?utf-8?B?TVJpSkxPNXlmQnQ3N0oxbzRiL1kveVpyZVlkRzFwWFJsYXVpYStjTzN3M3hX?=
 =?utf-8?B?Y0NxMytwSm5CbFMrL21Yc1VMVk1nUU8rQVJyelBQR0M0bVZWSjBuRHhqWDlE?=
 =?utf-8?B?RFNDRENzOG5XeksrVXlENzhFYk1zUWdSQi92N2FJYjhCYnA3N0RqT0xib1VD?=
 =?utf-8?B?RTVVbGtzNGRUM2lhQUErbnNGVlNNNjh5UG5hc2tqMmlPc3M1MllFazdZK1Nu?=
 =?utf-8?B?YU1jN2tPUXBMdW9QdUlkOXQvZEp2OFVnNUt6RUlFay9TZi9WdC9qbHRMdkZK?=
 =?utf-8?B?OWRvUkthWmU4MWVleVk0c2g5YXRnalpNTVdVcnZGNEJWdFhQc280anpBV2Vs?=
 =?utf-8?B?UWJNcGF5U0hmSW1qaXAyYTBYZEVFRVhkaEg3QS9zYlJDVythbE9MODFHQkNn?=
 =?utf-8?B?OE5nazQxU0U0WmJ5eHZVSGxTcmlQRkNOaDJkbGF3L21VUnVKRDhjR1kvMTNE?=
 =?utf-8?B?Z3p5QTl0VUhYbmRwTVNnNUU4RkJxZWFDZTJWTTZFckloZ0ZSeVh5cDlrRW5F?=
 =?utf-8?B?dlR4elBMWTZKYVFtQmlneEJQWDR5eE5JdFlGd1kyaVpLKzJDQTBDM3U4ZWY0?=
 =?utf-8?B?WnlxNUh6RU14T3V3OWpTTDBLZzZqZkJVblFsS2NPY3JQMG8rV0JiYTd0b0lt?=
 =?utf-8?B?TGZDU0grSW93eHFrZDdqWklSWkdoSGx4SUxSVzNZS2hXVVFLbERNaHp3WGVr?=
 =?utf-8?B?RjA2aFdxYkZpM0xpUk9mYnRxN3FUc3g3b1I0Mytja0JValluQy9vRmtNTFJp?=
 =?utf-8?B?NWo3MXhodnFxQldXSkNyM01SVnpxc0tjU3I5YWt5Yys3M0V4eUozV3Uyc1JP?=
 =?utf-8?B?WGUrZ1JoQnZPSTE2N1dHS3c1ZktTZGFWQ0F2SVhKamlPYmlGbjAzQUliZzhw?=
 =?utf-8?Q?HOZhZXIqYcCqbVlEora3AjM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa17ca99-7fc1-4b6e-eefe-08d9b99ea718
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:28:51.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syl0j31VRb/VZnkWZqnvLvM+FGC6AbTpi9aSjcSD2lYMaSTU/Q4SAg01BBS994sJ2ju4uYMUkwelIf7wKpNPew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3170
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 03, 2021 at 11:17:45PM +0100, Borislav Petkov wrote:
> On Fri, Dec 03, 2021 at 02:00:15AM +0000, Yazen Ghannam wrote:
> > The AMD MCA Thresholding sysfs interface populates directories for each
> > bank and thresholding block. The name used for each directory is looked
> > up in a table of known bank types. However, new bank types won't match
> > in this list and will return NULL for the name. This will cause the
> > machinecheck sysfs interface to fail to be populated.
> > 
> > Set new and unknown MCA bank types to the "unknown" type. Also,
> > ensure that the bank's thresholding block directories have unique names.
> > This will ensure that the machinecheck sysfs interface can be
> > initialized.
> 
> What is the advantage of having a sysfs directory structure headed with
> an "unknown" entry vs not having that structure at all when the kernel
> runs on a machine for which it has not been enabled yet?
> 
> IOW, if those new banks would need additional enablement, what's the
> point of having "unknown" on older kernels which do not have any
> functionality?
> 
> IOW, how does this:
> 
> /sys/devices/system/machinecheck/machinecheck0/unknown/unknown/
> ├── error_count
> ├── interrupt_enable
> └── threshold_limit
> 
> help a user?

Yeah, I see your point.

> 
> Btw, looking at the current layout:
> 
> ...
> ├── insn_fetch
> │   └── insn_fetch
> │       ├── error_count
> │       ├── interrupt_enable
> │       └── threshold_limit
> ├── l2_cache
> │   └── l2_cache
> │       ├── error_count
> │       ├── interrupt_enable
> │       └── threshold_limit
> ...
> 
> we have those names repeated which looks wonky and useless too. I'd
> expect them to be:
> 
> ...
> ├── insn_fetch
> │   ├── error_count
> │   ├── interrupt_enable
> │   └── threshold_limit
> ├── l2_cache
> │   ├── error_count
> │   ├── interrupt_enable
> │   └── threshold_limit
> ...
> 
> Can we fix that too pls?
> 

Sure thing. But I don't think removing the second directory will be okay. The
layout is "bank"/"block". If the "block" has special use like DRAM ECC, or L3
Cache on older systems, then it'll have a unique name. Otherwise, the block
will take the name of the bank.

I think the more robust solution is to drop the unique names and use generic
names like "bank"/"block". A new file called "type" can be introduced into the
directory structure, and this can return the name of the bank/block. New bank
types will return "<null>" for the "type", but the directory structure should
remain the same and functional.

I've seen this in other sysfs interfaces like cpuidle,
e.g. /sys/devices/system/cpu/cpu0/cpuidle/stateX

The "blockX/type" file is like the "stateX/desc" file. Or the "type" file can
be called "desc", since it's a description of what the bank or block
represent.

Here are a couple of examples:

/sys/devices/system/machinecheck/machinecheck0/
├── th_bank0
│   ├── type ("Instruction Fetch")
│   └── th_block0
│       ├── type ("All Errors")
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit
├── th_bank1
│   ├── type ("Northbridge")
│   ├── th_block0
│   │   ├── type ("DRAM Errors")
│   │   ├── error_count
│   │   ├── interrupt_enable
│   │   └── threshold_limit
│   └── th_block1
│       ├── type ("Link Errors")
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit
...

OR

/sys/devices/system/machinecheck/machinecheck0/thresholding
├── bank0
│   ├── desc ("Instruction Fetch")
│   └── block0
│       ├── desc ("All Errors")
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit
├── bank1
│   ├── desc ("Northbridge")
│   ├── block0
│   │   ├── desc ("DRAM Errors")
│   │   ├── error_count
│   │   ├── interrupt_enable
│   │   └── threshold_limit
│   └── block1
│       ├── desc ("Link Errors")
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit
...

I'm inclined to the second option, since it keeps all the thresholding
functionality under a single directory.

What do you think?

Thanks,
Yazen
