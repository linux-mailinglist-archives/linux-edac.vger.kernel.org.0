Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515FB5708E3
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jul 2022 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGKRb5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jul 2022 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGKRbz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Jul 2022 13:31:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046161D81;
        Mon, 11 Jul 2022 10:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV36GIWDW6WaQBzkP/AOJlxs3tQKFnxQRcjhuHnNT+fopN8h/BSLlibuLBzYNevQk1SW5giEcNhndu29QqyEKws3Cgc9Fc11X04b2zc2j8nkPfTDpnynavK1Nx7ERUzSBGoNP7JiFWRJBeYju3T7BooYzfnfoDt/unQgzoyhpg2jpLEGEns1v6+8SnQUztv69joBLeFkwFyq5l3y/G8nV3GivI4HTRk0Kwc3ChOEqNHDSlzTXaV+tFK99n6t4kYCiofoT5toAsXBl0XyHZhkNHs1bgrm4bXYjbKfEggmbwtLZoy541T0QOR0XJTFMr9sN4T5SpEKF1W2BH+pUf1SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F6in5AoW7k1dDBlc3pmLq7Rqw7l7iZdckICnZ9YKho=;
 b=ICcxpXsjxhdbjvlYI6oFVum+NksDpzQgeSuOlWLodYok8Wywg8saS6mkQXae7v1D+7D9YxIVaqZSgzvt0r6yyHpHXOValu5MUtSqo1AMk8v76yp9a91cByb9oERLEWWV2B7f4r0jYtwiw4sCiWWDpldZ6k31Eza/ePPCz4DnWoAY/wW3zY1J56aNzTaXRKFXgtIfBHKgmoHx+Uj6/RZ0229iwicq8q6gF/Z+suGN77w0AgaKK8FQk1GWpLy0NGfrYkxoRjKFm9JmKgV1jrDrAbIccH4O5MfTIvGhX4Gn2S5ov2imhbkQflVyfNe4tFwPDyDf1KYl9T/uvvKGkc53OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F6in5AoW7k1dDBlc3pmLq7Rqw7l7iZdckICnZ9YKho=;
 b=DGCPOjILwsD8dRfEg9rT849vrd88WMfkndFXt817K+b5xvv3pEcl5yl6pVw5IVgMlY0oFIn9WBVpmB52IeJ9kZjxz2FRvnLort1dWd8oDbrqH0CzzhO24u1jhMhpUex02OXD2w3RUeO3/KDHW2f8CBPsrAokYWUZ9UHa6RHKZ9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2834.namprd12.prod.outlook.com (2603:10b6:408:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 17:31:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 17:31:50 +0000
Date:   Mon, 11 Jul 2022 17:31:41 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <YsxefXQDCiJ1zxLG@yaz-fattaah>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr2CpuL+JHWblJMD@zn.tnic>
X-ClientProxiedBy: CH2PR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:610:5b::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5775de66-5a2b-49b1-c16d-08da63633cab
X-MS-TrafficTypeDiagnostic: BN7PR12MB2834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6OI9ZaJ49SgncTc+xx6PWcgwHF0PUsIB/9k7X9yXOOMEoaf/NxsV6j3THTDdbgzUnUxQftAAu1lTsYft5Tn5NYw1TpXQ+haT1lhspkOBz4zOyNN2OifSi4YAPnqMLNzay/JwNJiBFwys5if3G4tbaQij6z1tB4h0uvGZn/GNsWHk/Cz+PrrwrkddweecJCJ3RZ+tTQXCHj7at1u1vd4UX12HSYeinTrZhfR1B7BfOE8rAHtT1j77z++W8ExNQXRK0O5noX5obgoc/fZy0ly5R+W6NjYC7aZXizeFmmmhUBZIHxii3DCrDs05hta0a2LXR6YdIYRBEDtuPCjpqganD+509TVeqWvGbqv5puRloeYzcw6xsALjxNyjKHh3z+zCp9SH+MvxLwMg5vAn0BXZkAdhMx46z6nqOhKlQIDLa2ltlbFQE7UiZ8A8+pITzjopFmeqh884+NJwsHye2joPn5fMKoWLoGqlL8hYBqwKMXogM/BrQ39m+sYBgIs51MwTE6eebuaEbihrQLoqeCyIRZ3FSdJzT+c3ZJAXyfz7aFFQzPboEG3l8zsJ+zL27dWW7lYjbIh8qdKMTwWRH9gdBvO4SRHXoAgPFxgv+hHwPzpv5x+f2L9AFs9xEkPTW7A9CrLHmDeiIuLyFzib6lTmAuxX6FjKaZMXkzMpNzuD7UCIrHnijN3S9Qx3yua38g1ihhkQusviECdyagS88R17zGRqThglYykKPBsx0dQJO75TLpmC1tUx+F7uUkb4ezx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(86362001)(478600001)(6666004)(6506007)(9686003)(6512007)(2906002)(38100700002)(6486002)(26005)(41300700001)(44832011)(8936002)(5660300002)(83380400001)(66556008)(316002)(66946007)(4326008)(66476007)(6916009)(33716001)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nf8SOul5FG/wB22N1aFIiiCQEM3uZZ5Gb7nTzNt+wWYPOzNcMiGE2mrV5v9A?=
 =?us-ascii?Q?bvBHru46909t/Cc1kXw1o84Sjp9f5pap3gJjCmS0NWO8xxAxJ7WXgKpClPnX?=
 =?us-ascii?Q?0W5PD8wVvBHjEjBXtrmrwW4afzj3kN3jw7wvwe8RnJtu8a8T4j+LXJQ2F9yX?=
 =?us-ascii?Q?gcSkFnow50je0970vkDXjEhEGaPWbN7LSDXQ2s93crqHyUGAWCZOkML2FX+h?=
 =?us-ascii?Q?QzSpfjlLhdT5L+YqP/MYCD8SpHMvHtrW0hrP9M/3na/+qUHx7dn8hfMiPFyi?=
 =?us-ascii?Q?KGF4cAeyyDxdEjibFZ0BMstukgoj8JiHhELK/bLYyUlF59Po09fcmnORWcoV?=
 =?us-ascii?Q?C+Gb+DlBzl8a7nAHQHZd3NMjGBEaIj5+ps5t6ndP5pSbzyM+sWkhiXhDjWsZ?=
 =?us-ascii?Q?9cM0gdfwTXLdp+oqwqubhtDmEvKS2OxNiiEuoR71ONF1v18Snqu7z9ToBJG9?=
 =?us-ascii?Q?ixz/YeoU+FIEJ27NLt5vQgcFtK4eVdSUEMDU8eYff2W2X31FQu1/mOWXEV4R?=
 =?us-ascii?Q?N6HMScfD7ZRVemgGzjqy6kMMF337PA/y7rqN/G6tYBxZ1AeV4lhAwKvyj+zT?=
 =?us-ascii?Q?qmCVQm3xR5V+MPAFxI9LlyU6T1mMV8mvzt8WjDZebkU8nRWghaDYnRZpmJGu?=
 =?us-ascii?Q?iFOU0KLHiJdcXGijFJF/80fiPeAwf/qyYwJfiTZ+IE6bX8qrdYPt39R2wl7k?=
 =?us-ascii?Q?KaEXB+M8CCQpimqLlPJpn+c0CmGye01jR/fMF8TXhx525clr1kA7DNB373y2?=
 =?us-ascii?Q?M1hNdLLmlJjD5nOtfYKNgFAd3bQjAb9Zy3BeJxy6oV1AFxVSwE3AL5fTybg3?=
 =?us-ascii?Q?b/P5qujsR2wY5ZXCIBlDOrzEZokkB/3Ru+jaEudUR9J1f5BqOU4BWJHTbl2r?=
 =?us-ascii?Q?yLd19UCQfNEXdmxcpDxe9BZzNScKtvoNi8jSb8fy1ujVPz8b2HnO92HY3hx4?=
 =?us-ascii?Q?6Pw+SL9W0WT5kRU1ycpb5KyKwZi2p4Zs5Ay7SSZJRE7tStoUZjf7Qzb/rL8A?=
 =?us-ascii?Q?k5enyJnyGt8fqWSTsSNT64mGIQumMIGsibq/rj5yvrH5L+Dix9e2allHjVB4?=
 =?us-ascii?Q?1bpzHhwUMGwgkrkFEsGQS7lSTMXjteTUz6nJXMiWgmInlmtQIg+Qg4yktjwJ?=
 =?us-ascii?Q?ozDohMM2d4xytZS1BmMOIvq5lhouTDFJrlo8srXIatg/ha1s7T/fqGy1TRKA?=
 =?us-ascii?Q?Hu7zYaSYoUNPw93UQtVJeH49EnHbBalWD5T/l4X/5cCgEmr8QLOrwRadye3K?=
 =?us-ascii?Q?PEGoy715GfUvTT/nlf7MdbBq675b42AHBQu12esXZSV3SnbOYsWcjNKYygvR?=
 =?us-ascii?Q?9wRmY7PAMzA8nkxZ+9rdyyMnsjgQvKFh+ucW/APntdh47pk5Ljh2ub7HSc8K?=
 =?us-ascii?Q?icriDRuZQb9kY221SbcrEagD0FCJgw2lTfNRgh0NWFmma2qS72uGwQzNlpJu?=
 =?us-ascii?Q?aSrgua/aniXQNFbBFi9VX98wFWXCc6aU+8Oe2egGdkoVlAqbfTRP9BRsNdRy?=
 =?us-ascii?Q?C4e+Nx+ygw+4DBwpnN8+/RNCDI0E44payfGPMu5lgUIWut9eB/rFtmeg6bb1?=
 =?us-ascii?Q?HR1J7AXZvRrHL+dpKvYy4iIBUeV0EHdyCZyu3H3Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5775de66-5a2b-49b1-c16d-08da63633cab
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:31:50.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdrZQmQiNyB422nCSATa0zLFd8DoJsKmRG2Xg4IVaYbJMm84ts9iTP2SAiQc71NTgUbqFyxumlwUdepCDr9RZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2834
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 30, 2022 at 01:01:58PM +0200, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 05:44:38PM +0000, Yazen Ghannam wrote:
> > Future Scalable MCA systems will include two new registers: MCA_SYND1
> > and MCA_SYND2.
> > 
> > These registers will include supplemental error information in addition
> > to the existing MCA_SYND register. The data within the registers is
> > considered valid if MCA_STATUS[SyndV] is set.
> > 
> > Add fields for these registers in struct mce. Save and print these
> > registers wherever MCA_STATUS[SyndV]/MCA_SYND is currently used.
> 
> That's all fine and good but what kind of supplemental error information
> are we talking about here? Example?
> 
> And how is that error info going to be used in luserspace?
>

I think the general case will be more bank-specific information. For example,
if the bank is a cache type then the info one format and if the bank is a CPU
type then it'll be a different format, etc. So I think the new info will be
treated the same as the old info, i.e. collect all the raw data and share it
with a hardware debug person.

The one example where this is different is the "FRU Text" case covered in a
following patch in this set. 

> I don't want to increase struct mce record size by 16 bytes and those
> end up unused.
> 
> Can the information from MCA_SYND{,1,2} be synthesized into a smaller
> quantity an then fed to userspace?
>

I don't think so, at least not at the moment. There aren't any "architectural"
fields that can be interpreted the same accross multiple errors types and
banks.

Is your concern specifically on growing/changing struct mce, or is it more
about limiting info sent to userspace?

If it's the former, then I've been thinking it would be good to introduce a
new internal "struct mce_ext" that includes struct mce plus other things. This
way struct mce can still be uapi, and things like mcelog can use it. And at
the same time we can new data used in the kernel or shared through
tracepoints.

/* Extended MCE structure */
struct mce_ext {
	struct mce *m;
	/* new stuff here */
};

What do you think?

Thanks,
Yazen
