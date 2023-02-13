Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1E69539D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 23:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBMWL6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 17:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWL5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 17:11:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D239752;
        Mon, 13 Feb 2023 14:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFvN6aWIU/Ot8GPMdaxj+xzcMlHCILDhXvH78NCr9V4GxYx45oQNdMJoW4/PSbAAe3ATrqKCqAfZ37bYYmmm12MJAypsBm89nXBLqi+qFX9lCC4jiy6QjGkD3NlR13qjP66gPnyigS9BrSb4mEX83sdraOJG8HLby+1RloC7FLv5Diy7MjZBHer1J0YmYxG4gup8qLT9mJKb2r782zt7CzvOV45eaXmrXhd8mlZloajYYvXSwib/Md/hleH2TzZzf4ap10k1+qPIB7mv7+oLcKK/afoOFJM4xeOE8kQ3/bLsUD8q0I13avsvsrsTjB4rxlu9xVsDU/1p3LfroaLtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WGtWNIAz0kRcMRzfJkkIHwN20yZLo44A7W0xOA7rJI=;
 b=AfsufaCxs+nl7zMxzOiQKFMyDRV7/jrNFEwNz+099kMjRCQ+ujfhzKCTRWPLeJP/MOMe2u9EpOIXtcfTwF4ulPHjfCxc/BO9IWhoASgQ0cdCAmwq1Ne+kFPKOrFIucpNoVwCsSO5mvPAFT2bc1L/cUQgaEJEq9D7eOx7BmfMB9Y53w9d2aWBcWyeHlsnMYOtzDJncpbGhR0JkmPh20MCBpjmAz2sxqaK3x3EfwDb6P16YqGVJNArnlOeVaZiqSRnpp5g4YOFn2mGAFrlh6gKXw8YDTqOccg2Ia4bHc9v6xHo6vE+oGzSQeI+SclZ4Y3sqbOeIQfPSNZ0Il09d+qG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WGtWNIAz0kRcMRzfJkkIHwN20yZLo44A7W0xOA7rJI=;
 b=Y25tEBevo71WBzHcAK57Mm0vtsG86F9O0WHc7N3Azv7bOY+odXpedzrQPTN1phlWAN9g+xhV0DnmOYbCpwy4NqMbGPcF3UMzZbvsys3KODqPztQLJ572/FUwnCKTpU+41vHMC7uITNHUw+kbY5Q2/d2J6R86+XrUzwjzyHTcHjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 22:11:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff%7]) with mapi id 15.20.6086.019; Mon, 13 Feb 2023
 22:11:52 +0000
Date:   Mon, 13 Feb 2023 22:11:38 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: remove unneeded call to
 reserve_mc_sibling_devs()
Message-ID: <Y+q1mhrAKTobp3fa@yaz-fattaah>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
X-ClientProxiedBy: CH2PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:610:60::37) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL0PR12MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb6b669-5a27-44b3-0c2d-08db0e0f4fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iwz1jaUsdiVz63nXq7PpS+M3AOFSFZroRUa4X34nyV1JuF+dVeNB9+U+XERc17i4suPO942PBiXf/w3eyAcUllK73JRksloXrGnlZctOgFprwwIVv2Xbb7yaWxkPLWQ1fgfvXoc9ulIguBdmwtD+PLpZnoED7LpdS96frpfZOMMMEKhiwZsgqiiwisT7T/tumAsNX+nfht0Z5PDq1k/T8lZ/n3RzSDIg1LKRMnxZfU2ARlanyEMclJWrNgxlg/uqfc2wLT0mukCJbwLCT+ISo5hR9dpQEHF7YJrTnHqV3UKWQv+EYJl0UuEpJfYTCkhUIP7wd9ewJ4i3SCU2k0mhUnEy0dd8dW+OJLlI8S7JlUrOpcD7t0/AwYbWF0Tz9tICWwyg+a6rh3qeBQZrBjGmjGDwPft9+RYYy+3F5trPKrL1xlz0o6w5Jg9HoDOEZqW1KXOXpIsyL6ARaMWWbzlBfW18aFh9iJ8Ff+hGuO4ycfMaakEw7DUjehSAOb1CdLGZ+iQo+WFU/mopAx9AFxE9d1Sn+WA07eFuxfjvNHkFVk0l1Q7QgblivQ/eTKryyXE6XyBmrd3mu41Zd0I2k15bMvCumm683XaKCnn+U4QstjSWvttjtWZJYhYc5thoY0DzJOBt10tIrXSWjljJzh/4/aITlsu3Lceo7ohh6UbJ6B7M9UqBcP65p1bwjVJBgdzBUxDTRMxgr3XfSV107MPuDGu7G7rYodQOoGXB24GXI6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(86362001)(5660300002)(2906002)(33716001)(44832011)(8936002)(38100700002)(83380400001)(41300700001)(66946007)(6486002)(478600001)(966005)(66556008)(6512007)(186003)(6916009)(26005)(8676002)(4326008)(316002)(53546011)(54906003)(66476007)(9686003)(6506007)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vhV8LK9Ea/WTGzpTcYbd5q+WjlixIw0SkdScG3eSaPULZu8WoTnCb6YhsMZq?=
 =?us-ascii?Q?m8HMTkeTug7icrQtObYhr7GoGxy+MVxa6qzdUx1Ocrzfdj1M8DjpKZnW2WSy?=
 =?us-ascii?Q?E1l/WO3jKWpKcNvNi8eIjbViWTsUsxnguwhHV/tZNuOyqFRQ07q0Qg7eRPE2?=
 =?us-ascii?Q?APOdsegJvDLgFbLaEj/ZHWvyBd6o6Gt5W3wEgHAYPUTrDhJFvmUhaPigMsKD?=
 =?us-ascii?Q?gA0J7BshiCtnQX3AWmFDcEfMkFqIg+Qa59/IVl+dw/rbnyynkTMPO8Y9NKNF?=
 =?us-ascii?Q?Zr5sOtULPDZKFif0kJLYFNek83O1t8nZeQnK0u0AECWKKQAwBzKsETLXn0DX?=
 =?us-ascii?Q?CwiPVRGfu23IMfdDUwlVOE0GYB7ZutVY7IPc8LTnpdcihZtjLRIwkh9ltIPT?=
 =?us-ascii?Q?bPGUIoy7EKuQuk2ZejPmMeaYHtNif1vElXxaa1xyc9Hhm8JdE23soSK6MdPY?=
 =?us-ascii?Q?LXIxWtE5oCIx7EikgYz9ZOYpJqIynesja2akZSfLFOSiGpPzMFXpJjoWoJq0?=
 =?us-ascii?Q?znjKS5qne5bEsYqMlvnWdV+rYM2ekNSG1ADgJXS37v5mFbINl8shf9l/u1eu?=
 =?us-ascii?Q?0W2NeI6zUFEAgc88vmOlvLbHF7QsP8UTirQ0aEcZQJ2lMvb7y1NZghHpOngx?=
 =?us-ascii?Q?kzkqNZ57Z92nKq6mzlNts9+kSXnz27p+co8FiFo82khONsKzwtFK0+bDkgZH?=
 =?us-ascii?Q?6X73pVNHFRm66WOrfcqJrrZXwPC5HRUh0UfLknR14j1gHnFiKoQt20asboWe?=
 =?us-ascii?Q?6PKAeUbfo9TL4XtTBXRq8FOCJ9xMKes+ycQSsPIVkkRIe899yRF/MYESO8zX?=
 =?us-ascii?Q?VYmKaNJ+2spvF3dxuwGDiGeu+K2i8ACo4EZoqA5/IXu79O1KW2/w82yrfugH?=
 =?us-ascii?Q?OwNxNLeZYbOhlQPYu3Lr6Ow08ARZAYsFDSNLfzwugSsxkc9vH6e33aSSdkVD?=
 =?us-ascii?Q?KygRDFTxjQm3rBxzKBYckT5jD5GOXjy0C/7wHg6NU/8v8+ZS3ISD+RV5zRMU?=
 =?us-ascii?Q?4Fp4Ue2y2F9ws6ysxNJGEDeRqVrnvMnYPII5ioZMtLqEx7Dju47OO4Rhj2Ag?=
 =?us-ascii?Q?/U4xwKeimp0cQ5CRFZUOunwS8SB4N/Dzq0X8jb6qAKvZ/0Lgar29YY1xNQNM?=
 =?us-ascii?Q?PdgU2tq3chjZp4JUAj8M8Qsw9qYaMDvKDQAxt3MK3RmbInojmtH0S1wr0y2O?=
 =?us-ascii?Q?OU60uxqSFCPgasfsSigzfHRLKH8Ff1vZwoEpwma89/rVe7KsSm6H1kaly1VK?=
 =?us-ascii?Q?R4z8nh16FXg8Blb1kykk4itkLQHKCvhhhbmXjgKHImo666JaFW2hLj7tKQZn?=
 =?us-ascii?Q?qXB4ELx1a4Ntvn2Kl2dxIWxSukhqBmaoH0UmLZ3cOmCqIwNBocJZdUjq++iY?=
 =?us-ascii?Q?oFURIG2CfI2iGISYMGoes5kPfyjc6wmY5gRIZDrl6+/ga16G05wFWi6raYIt?=
 =?us-ascii?Q?oQrGRcMdeVp7kHMWWhRoPdBytflghXGe33TrQp3ITvJQxC2eScG6q9zK1+3i?=
 =?us-ascii?Q?UJWeQuWkbXxpHlc0NXFegYKRs6xIY/8ql8FOIncW1iW3BMfbxEvL5IWB/OrY?=
 =?us-ascii?Q?oXtLMnu6MaCBMRzYVU7xzqDS7zKk7OAAPQcHDckE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb6b669-5a27-44b3-0c2d-08db0e0f4fa5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 22:11:52.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubQdrlLFuhEJZhpKdg5KnyuBqSHYKMD0iS6Q79FomFidSF4xrM+X/pXY/bAD8KHd0mQ4rG4JR9dcncRUYnUaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 13, 2023 at 01:17:51PM -0800, Tom Rix wrote:
> 
> On 2/13/23 12:28 PM, Nathan Chancellor wrote:
> > On Mon, Feb 13, 2023 at 09:23:47PM +0100, Borislav Petkov wrote:
> > > On Mon, Feb 13, 2023 at 08:12:38PM +0000, Yazen Ghannam wrote:
> > > > These errors are encountered when extra warnings are enabled, correct?
> > > It says so in the warning which one it is: -Werror,-Wsometimes-uninitialized
> > > 
> > > Don't know if we enable that one for clang with W= or Nathan adds
> > > additional switches.
> > -Wsometimes-uninitialized is part of clang's -Wall so it is on by
> > default in all builds, regardless of W=
> > 
> > -Werror comes from CONFIG_WERROR, which is enabled with allmodconfig.
> > 
> > > > I think the following patch would resolve this issue. This is part of a set
> > > > that isn't fully applied.
> > > > https://lore.kernel.org/linux-edac/20230127170419.1824692-12-yazen.ghannam@amd.com/
> > > > 
> > > > Boris,
> > > > Do you think one of these patches should be applied or just hold off until the
> > > > entire original set is applied?
> > > I still wanted to go through the rest but I'm not sure I'll have time
> > > for it before the merge window. So unless this is breaking some silly
> > > testing scenario, I'd say I'll leave things as they are.
> > This breaks allmodconfig with clang, so it would be great if one of
> > these solutions was applied in the meantime.
> 
> This happens at least on allyesconfig clang W=1,2, i do not know about
> default, it's in a bad state as well.
>

Yes, this breaks on a default clang build. I just used "make LLVM=1" with the
same config I used before, and I see the error.

GCC doesn't seem to have a comparable warning to "-Wsometimes-uninitialized".
I went back and tried W=123 and no warnings in this code.

Building with clang was straightforward, so I'll try to include it in my
workflow in the future.

> It would be great if the clang build was working.
> 
> Nathan's patch is fine, go with that.
>

I agree Nathan's patch is fine, but would you all be okay with a simpler
change? Initializing the variables (as below) will silence the warnings, and
we know this is a false positive. Eventually this function will be reworked,
so a trivial workaround seems okay. What do y'all think?

Thanks,
Yazen

------

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1c4bef1cdf28..5b42533f306a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3928,7 +3928,7 @@ static const struct attribute_group
*amd64_edac_attr_groups[] = {

 static int hw_info_get(struct amd64_pvt *pvt)
  {
  -       u16 pci_id1, pci_id2;
  +       u16 pci_id1 = 0, pci_id2 = 0;
          int ret;

	          if (pvt->fam >= 0x17) {

------
