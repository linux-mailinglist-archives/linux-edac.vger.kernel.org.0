Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1318725008E
	for <lists+linux-edac@lfdr.de>; Mon, 24 Aug 2020 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHXPLX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Aug 2020 11:11:23 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:15456
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727924AbgHXPLT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Aug 2020 11:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVyHh/98LHyDbW5Dlhtx4TGCLJgcO3nglHHvI4FXt7BQattJpZgyeC8M5YNVgRadcdDH1ODFzy7Hs46ATrwk9DbiQLVlAieB21Mw+cqOA9dfzFaCkVLcxwSL92eLemVii8ixMq+RAQZk2y/BbkTvRnkgAJdq/OIF49Iyi/rw9FH09WceE5LirPZGHlH3I7O6iMaPgWE4nqB5ZWZsOn+WyLfQd45O1FYg953gLpyiQma+Lax3ggJuMSlhPswsaQSl7ap3b7OPDKhoEUOMehm9pe4lsJVjw6XqmueFnvclkWWt0wAL5/tLXHk/MLlAN2yuhrRpIhZGC2EVXBhVMm2TBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6gP9KLD+dOqCRhFax5ZavJWV5Hbm5Eq4PUG7zKb4G8=;
 b=DnnES3wGYYlpj9dZkxJGK1vUXqDGRW2mDJtz/sX0hqaOhHNo9cOMXrPMMuuxo+TbE7qKCwgeWYH8kD0vRLMINvZdSb07UFVARFrhOBBa7B+5g1RR6A2HwcD8twzRFYtq3WK1Lq6VoVJLFAgSdOOmmwMSkbJwzVaVRhUeW5lRxLD5No8FDQma7QAKAAnLMliYf/13LIGMjGziRVaFu637mfUGoGuJ4e71hEYP/W7oJiEYyWvhKW4qT8mjUqxUvafeMTkcL1ZlgzFRHRHwYbwdeoH90Srg/MKG5HOB4rexQx9GZJ1HWt9RErPvNEP+PhC54VKmnsUqHTZ7ab9wovlNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6gP9KLD+dOqCRhFax5ZavJWV5Hbm5Eq4PUG7zKb4G8=;
 b=ukhfwixSdgStPBHB8ouAl8aVUmV06Yw83I4m6P6dfXxES49omgCQJnzg41kmgKMIFcEPJ4tg/Wi/ELTmEfVopdCtoApdcpCcj4Dw0jTIPVF1uSX1QTr6ac06hdWaw7tlk4wo2ZqhIyhhb4R5+LPej/qf5vJ18ScvEUseoqqyGxw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2978.namprd12.prod.outlook.com (2603:10b6:408:42::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 15:11:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.030; Mon, 24 Aug 2020
 15:11:15 +0000
Date:   Mon, 24 Aug 2020 10:11:05 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH] x86/mce: Increase maximum number of banks to 64
Message-ID: <20200824151105.GA3478291@yaz-nikka.amd.com>
References: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
 <20200820171518.GB17271@zn.tnic>
 <20200820180054.GA2033274@yaz-nikka.amd.com>
 <6ecac9c40d7b4491b9a87c8927a4aca6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecac9c40d7b4491b9a87c8927a4aca6@intel.com>
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by SN4PR0501CA0065.namprd05.prod.outlook.com (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Mon, 24 Aug 2020 15:11:14 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a97c9511-8ed1-4e04-8552-08d8483ff1ba
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29787A8B500FA09CF37BFA75F8560@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlOMogg9lmjIgcq9hVNqHyOeEUDMrhjk8AyMsoGHBgWVbrfahnZtrDaOv85C/IlVCmeiR0YOZbnGBk5pV9wQViULooCwIrlEqdyBjlWKrsExtIqCoR4+z+UijMFVgBCNlorYAUDJWhc37P9qyuZSpOTTFWnYryD68lQniVLKqKOuO5YCpYVna3rXoRR6LQvZVXg2BGLSwWAjrGGA2YS0c0TKX2F0ZVyzT2+CcE6SXuPrPDAyZC5EnWPVdeIJ5QsQ+o3+DfS6SwtQrcWQ7VGrGcRdSPd+jU76TR7lIQ5li91K7ExjMdZn8z9rzFSZI2o5f4ajY9k9Bxv5gwdVw63ErQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(6916009)(1076003)(86362001)(54906003)(7696005)(52116002)(33656002)(478600001)(26005)(55016002)(4326008)(15650500001)(5660300002)(83380400001)(316002)(186003)(6666004)(8676002)(16526019)(956004)(2906002)(8936002)(44832011)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: u4BMNvd6IoDfvO0AbEFTbEYhYaPFYC3qEx3tHXU6mrsnIYjiP7C2u1RlBMtYpgjf8aB2TgQ+2/jhhq0KHfpxTunHuDaiCagXPWILmhj/Xa7oD9Td7J0X6YtOtMcmUuPoIGhGWLxhSBRAfMKEkx2ay+1TD9qyXwqJWcgzkks5wLDXN97NWteOzJnS167JTJ7mdHse9ti4dvEoBqsedFZbLbC7fdRkE04vdYd2jm2ouPVRn5XcCIrPLihH6xmUjdCf0XtSwmuxLBNGKgjJbE5fUipm8j6G8RlnQ9Z3j5snyqpMYsvmx8LXrXzk0imSlKdA9s709juWWjiEB8GoOGoEcqKKPyFggEJRx/3lFcXTBVk8yZ0j7+/DtaIaTgWyJfI9/n7Dwe8hI6rli9VImUtrlbP2Yg8ivao9ePyqFnySpWctl+VUlbbLdbMqlaxQJqh3aqn7BU2e8FOdAu0FHMrcx5hxoa1B8TagLuM3uMRFlaknYobNnoQ3DV3im+h8a83p/VIFpHXDnqLsYC+lCuAyYTqWZJCBijj6G1g+JpRM7kKfsXPfTCyPo2cLDRiN22PhUMsfcjr6EwyuVtICjg5fSlDAq9sBfuUAB3Kk77jXlLueYYdtEPVtA1t59exYgLIsrEpqJpH5B+MrKWez3U/BdA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c9511-8ed1-4e04-8552-08d8483ff1ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 15:11:15.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1t54E8abmwdGbeRnMjfacUgERKzb12I8YcinRKCJMEhbSeQWMjWmmyDpKRVv65XWPAUFWLiDY/LU3nalYWQqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 20, 2020 at 06:15:15PM +0000, Luck, Tony wrote:
> >> How much does vmlinux size grow with your change?
> >>
> >
> > It seems to get smaller.
> >
> > -rwxrwxr-x   1 yghannam yghannam 807634088 Aug 20 17:51 vmlinux-32banks
> > -rwxrwxr-x   1 yghannam yghannam 807634072 Aug 20 17:50 vmlinux-64banks
> 
> You need to run:
> 
> $ size vmlinux
>    text    data     bss     dec     hex filename
> 20334755        12569682        14798924        47703361        2d7e541 vmlinux
> 
> Likely the extra space is added to the third element ("bss"). That doesn't show
> up in the vmlinux file, but does add to memory footprint while running.

Thanks. Yeah, they're identical:
   text    data     bss     dec     hex filename
   15710076        13519306        5398528 34627910        2106146   vmlinux-32banks
   15710076        13519306        5398528 34627910        2106146   vmlinux-64banks

I did a quick audit of the statically allocated data structures which
use MAX_NR_BANKS.

Global bitmaps:
- core.c / mce_banks_ce_disabled
- core.c / all_banks
- core.c / valid_banks
- core.c / toclear
- Total: 32 new bits * 4 bitmaps = 16 new bytes

Per-CPU bitmaps:
- core.c / mce_poll_banks
- intel.c / mce_banks_owned
- Total: 32 new bits * 2 bitmaps = 8 new bytes

The bitmaps are arrays of longs. So this change will only affect 32-bit
execution (I assume), since there will be one additional long used.
There will be no additional memory use on 64-bit execution, because the
size of long is 64 bits.

Global structs:
- amd.c / struct smca_bank smca_banks[]: 16 bytes per bank
- core.c / struct mce_bank_dev mce_bank_devs[]: 56 bytes per bank
- Total: 32 new banks * (16 + 56) bytes = 2304 new bytes

Per-CPU structs:
- core.c / struct mce_bank mce_banks_array[]: 16 bytes per bank
- Total: 32 new banks * 16 bytes = 512 new bytes

32-bit
Total global size increase: 2320 bytes
Total per-CPU size increase: 520 bytes

64-bit
Total global size increase: 2304 bytes
Total per-CPU size increase: 512 bytes

Is this okay?

Thanks,
Yazen
