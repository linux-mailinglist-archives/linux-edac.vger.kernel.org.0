Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C01C6C3D
	for <lists+linux-edac@lfdr.de>; Wed,  6 May 2020 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEFIxl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 May 2020 04:53:41 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46104 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726935AbgEFIxk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 May 2020 04:53:40 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0468pJrZ008504;
        Wed, 6 May 2020 01:53:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=2tJa14CXTsIt2yYVYawk24tGE0vvEF+CcwKzwbH1Zsk=;
 b=Vc0ZrtPfl9N9hPXy3M1Y6DVqWasZktMOfBrYb3rTmxChks25NTAwZhSEPFwnMTgCPPdw
 WAkb+aRTfQlRXftLEzLmDAn5/gVSIfCXIwKehkiSXHSZmoORbHp+tXXBccRHOZf4CoRx
 r/X632BPu8Sx/0YNhfhWKBucgJeSj/ct4SwJ9vFkC/QbUju7XJr0YotfwdZPuAG2BzDk
 uDnuplmdy6vc97va+Gjr7Q8cLeiceGdBh49sgorHln83y6ZmbGbPheJPI75e7dVv1b9H
 nymaroQTRr068hkUi1fna6IwMx14hOPbYCWt6n8/yYuitfd4ICHsPQ4nbW7hi05oQE9X 4g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 30uaukv713-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 01:53:26 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 May
 2020 01:53:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 6 May 2020 01:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGKALwdgsuw5HPIjsNJT6rILii2fK9ZSvkb4K7X37JR7BmKpb3DTqn7mpK9C0oCHrUQfuULc76Pzjq3SCechAjbzW3G1QaMGKFjguEOi+46BHa7NGtkljyuVKodXqp2eXYzlNfXb8Gn+7TipbwjEao3B6Wnch/Ybfv2aP6pZJ8iMwx2d+OwhaVlHGUJ+qhVh+ZMFpd+dP/u7GPybiV9y4yFkVawZ8wAHBzitmj2KSdmkVE7rLmAMwQTnn+8mO1GmO52q41YcY7TqzWzrpYsSQHIQqrqDtCyB8PoY8r6zyxmHryFrE0BmbLxOTmgDsHp/QcbKtFh/VwV9SAu046SkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tJa14CXTsIt2yYVYawk24tGE0vvEF+CcwKzwbH1Zsk=;
 b=lUQuDbFziv5/5VSkL8yxXxoBrtLglkgjpHZu/woO0usjLFDRJ6ovMnRRzWW9CFNvQ0orkNWRN75YJjDJXc0ZOcDcrXzbN0pILfFvr2KV4fDfnxauRjuxjKDjka1gHb47lQDEPy6jWo0WaoQkIDx6qPlAagDqqNIGFxbeEB40abLCUVg03w4V+s932FAzD+QUPfSEd+krZHeHD00CVYZGLp8K2AVrP6VF38xHGwoo4JOi4UAmEbensdV1jtTcZMOM/q6A2QCxmcYCVbFQ228z/9Yhq+JChj2csXGR+eaK3FBEsnOZtoHsOqZA9sD7nNdbwcYN8KBL9BdztCZsFNYm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tJa14CXTsIt2yYVYawk24tGE0vvEF+CcwKzwbH1Zsk=;
 b=aX8/XJWUF5MEyPURXjYupmcF8vi3dp8CDyqGhaddvp+54W2K87zIK2UFp2BaPDtC/UDAmQuZnYamceSwMe0kqAwrgGt5HQjdibkBBzRVWkaYXAqkJAAo+SNYcWwZWKdOyb6MzS4ubQBahkJB2g8WcqcYTxSYJYQzBt+xUW7oP9c=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2408.namprd18.prod.outlook.com (2603:10b6:a03:12f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 08:53:23 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 08:53:23 +0000
Date:   Wed, 6 May 2020 10:53:14 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] EDAC/mc/ghes: Fixes, cleanup and reworks
Message-ID: <20200506085313.hg45zw2z2rlgzmq3@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-1-rrichter@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR1001CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR1001CA0010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 08:53:21 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a67aca-b693-4b78-f90c-08d7f19aeedc
X-MS-TrafficTypeDiagnostic: BYAPR18MB2408:
X-Microsoft-Antispam-PRVS: <BYAPR18MB24087CF1CE579BB0AA561557D9A40@BYAPR18MB2408.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPwtGta31ILEJq7cygJPLKmFhKYzIOlWnBLsnybZROoQ/7he5AE99LdzWeimLGuzW1DYN5f7l/iWWZjvJcryxmwnEPdQTpY/fOe+gjNZBuriA98cXm3+JdZCu9qrR2Dgp6XXsttITLwEn/tG8lmJLTlful0K+JAua1hcqQVcUxC33LPI3AGWAnqKtL0p1CdKgnUkcW5oc+fFJJTnF7u+2x9HgUULoLxMfhvGQ+XhYYziyM4DjURRJWuGfK2qnySw5muia1u4/Dx03TSywW9Aob0Mb0r91B/JXJRTC43u/tCoIATqvOvrv8qdGt1+1289xb5BKtIFQWh3+jpqC0GI6AWa9NtnkOFz5mJUl59vGoXiHYTsJqFTtOoqGa5rSXLR/Jl3IZI0Je2ErNZCftcawedaCYLNnMpzK7SeqqMJG5xmD4X3pxRjqhsd8BMH+ulhE959RqdqAunl8flH9bUZG2f0hxCf1G052205LBrhahEsR5m0MjWys/rCRsXg0/BmCaBnsOQaDvap3PxWu2+KOSY9ScmRwiWglFLOHCms1f5Al6it8tezy1eYPyA5bvE80ZxSOA/pMPWqotfiNcnGfhIaAgGyJ0PSmMotfTkUobc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(33430700001)(4326008)(66946007)(478600001)(66476007)(66556008)(5660300002)(966005)(2906002)(1076003)(55016002)(9686003)(8676002)(86362001)(8936002)(956004)(316002)(110136005)(54906003)(6666004)(33440700001)(16526019)(6506007)(52116002)(26005)(186003)(7696005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gTLleX4Uo+WpEgu4nDRt8dU8HozKI3AwWou0woUNhLF1XbUgyrY3QpqSXa7RlXnZr5vbl4uWMWPZ/6Wqn5Qbshd7d/ywHB1rN9cfyYmVgjR6Hgea0cnKSghxf9rKxeQXT+rCzxonLJ4KdhQx9JBBMYuqflfoMs0kXhiKHra9BOHbdBq+i0XaidAgL65HbELlINAaAkHqZoUJ/UpcIqIlJg4grImMWsuDzCU01/9wFqfLKK+r17+4Wgpx6eiHLAqPdK4tmfl95xyQ1jzN5PXrbaROYAUiWTu1tJChjYTluz7R2VVxrkWRd5I8KaZW9JO/JDanG9Jy37TQWUvg+n0c/+u6LvNbkJoYNNfG6Is0gi7kD2UcWjPR+v1ksrC5zHGokM5iOupVENMKkiqugLQ8MeYjl2oE4r5VLyBUyHmUTZ9o+C2nxmKJSrQb95lpJl9OrYa9JgQb6GbY0fzd5GeQ+rJ/flM7f4W7eo+8c/Ttke7KrkU8Wra5gEutYEcTkQaJapGgd9Ui9dOBZJqvDic3MBAw07GiMEYHhwbwueI9tMhisn7rNngv/qJMBdUZcWArQcXFG61N3xKeF+ZnRuVb4g+LD1gm4c/AaNUjz8eBpRMw4ENaDwcGaoRwgbtSA0ERYuUF7X2NnVq4Yla8PW88RFcNmetDhyEtIdB8Q21LvSvuBtBbJrrDoyfegBlSGLTJQ1hBNuITn80g3IGvI2y5LmPkajm0Y4g7G6APffYN0IMX300MOcNdPY/ra5ScQOBB8pkzgt6mFmeLM2zaJJ3R0/tF7Dyi2Wj9tyOneSYu+Ss=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a67aca-b693-4b78-f90c-08d7f19aeedc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 08:53:23.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZCgJ8WVDLWhM8J/fvxRyHUjGtGyGAZ91W+ikLXwW95jTGrWXO8mpj+dwiqPJ0d4MYA/1mJnL5HNaHPwGFqqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2408
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_03:2020-05-04,2020-05-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Boris,

On 22.04.20 13:58:04, Robert Richter wrote:
> This series contains edac fixes and a significant cleanup and rework
> of the ghes driver:
> 
>  * fixes and updates for edac_mc (patches #1, #2),
> 
>  * removed smbios_handle from struct dimm_info (patch #4),
> 
>  * fix of DIMM label in error reports (patch #5),
> 
>  * general ghes_edac cleanup and rework (patches #3, #6-#10).
> 
> First 2 patches for edac_mc are individual patches, the remaining
> patches do not depend on them.
> 
> Tested on a Marvell/Cavium ThunderX2 Sabre (dual socket) system.
> 
> v1:
>  * https://lore.kernel.org/patchwork/cover/1205901/
> 
> v2:
>  * reordered patches to have fixes and struct changes first, code
>    refactoring patches last,
>  * dropped v1 patches #9 to #11 (multiple conrollers) to handle them
>    in a separate series,
>  * rewrote patch to remove smbios_handle (based on v1 #9): EDAC/ghes:
>    Move smbios_handle from struct dimm_info to ghes private data,
>  * added lockdep_assert_held() checkers,
>  * renamed struct ghes_dimm_fill to struct dimm_fill,
>  * renamed local variable dimms to dimm_list to avoid conflict with
>    the global variable,
>  * removed dimm list for "fake" controller,
>  * fixed return code check to use (rc < 0),
>  * added: EDAC/mc: Fix usage of snprintf() and dimm location setup

thanks for review.

I have addressed all of your review comments if not otherwise noted.
Please take a look at my replies to you. I am a bit unsure on how to
proceed with 08/10. I have sent you a detailed explanation and hope we
can find a solution soon. I could send a v3 then.

Thanks,

-Robert
