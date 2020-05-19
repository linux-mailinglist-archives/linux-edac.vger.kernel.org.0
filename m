Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A391D9361
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgESJdt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 05:33:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50752 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgESJdt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 05:33:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J9V0iD024492;
        Tue, 19 May 2020 02:33:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=mvk9dkSP0rYVhUxAdqX8J/M5nIas0a5oobDKKNh8rC4=;
 b=WJuPkZl7Kjm+W1HdjFsZidT89s4F/HqbaCwtxRPDCluXvlRHmvzB19N4WzTW4J5OkkhR
 9QkYgfkx3uT5sBxuSg7fWoanU0/Lr97cX4xCCqcpSMgp5uCv6ERHovpeQYHgYf2raxVA
 t6owBtQeBroxYN7FmIT9oa6/68L8BNnH0z0O+aNxcyp4luX0lnn+s9IaBo6lNKV+Wu9k
 aD9FSL+DomALaAZrz3uEds6hYTlZEZ4V+LTW+vWTW1AunFoaM8QTVbylkBajP1pdiNqe
 nC31fYQmkk83orL2e7YRVm0UmC6SGK+gmQXUzzW9wGwkb5HShvnapHRcQ9+nfWxIRPi/ rQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2qu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 02:33:37 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:33:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 02:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXb/bS4zEm4NttE++Nrmflf1TM4sAQM3gOwdG+F1kbOCzu9VE9F+xX5ZpL0rzA5baMk5LQCCmxzGugFOVo3LbTFUnKiuUOGnky1AEG1XueotTJb0YYoFin8QlwGfm76OJp5GeqBWbD84h41e/LHH+D3XdRPPjRcwV1xLg8+YOxm1ShiJsfbdy82d1xXbDRhW/LCCayzUhm9CanrWHPKDkQcks4BOAZ6+p6wvp1vVAou8+Qudmy+1aMGOkPoK1I0tZ1N23kzEaEkpxWkMGFaarsCaKIFHixTV8OzHMVLHp9vAjI5+fK3+bb6dx0mJP3oZ00I8dqXP+P/6aOkX+SUO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvk9dkSP0rYVhUxAdqX8J/M5nIas0a5oobDKKNh8rC4=;
 b=OPqw/Wj0EQkrUuuMh/NzMmFtrQILi/Z7rrSIN3Que+HyCla2xVZXw3FqH9sY7npksPjQhQnriV6cwTx77qhLHyVPjadO2XGztj0HUh7PzOxVOpNhadXViP42HN67hoq8h70GUMj9v88+XlwX5JF7wks2Qpv8pOxuTvFFJ0bVP9v/Td68hbioM5W8SZoOvF0W00Jj+xEs63PYUXbsI2IiJX8s5Aul+DwvcfGLvys7t8Nf440BHGmlu4+sw5vPsEYL8FQtZ9cHb8qw5G7VZGt0Yj/acZwsrbiwhlwHJldOc7RxjKSrTmDUbhtnINrgFLx1BdcWp8QRKR5l36VTUafX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvk9dkSP0rYVhUxAdqX8J/M5nIas0a5oobDKKNh8rC4=;
 b=hJ3p8CBACDnKHRBYlYNdkLuZlc357RPYy8c4nobMQ21Mj/Qwhgz1JL7wNHEnT/lnMfl5jz0agI9kan1DnF0MF2Pz7eBOzGW/1ooE0OT8VD9DdhWlg1Qitzp/Z+9peqSmtxn5G/z6rNfDmjIgGAKWZigFiSGbDXrJK+/DFrjfn9U=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2998.namprd18.prod.outlook.com (2603:10b6:a03:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 09:33:34 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 09:33:34 +0000
Date:   Tue, 19 May 2020 11:33:24 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] EDAC/mc: Use int type for parameters of
 edac_mc_alloc()
Message-ID: <20200519093324.33pamvpzhxuzg7a2@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-3-rrichter@marvell.com>
 <20200423174934.GF26021@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423174934.GF26021@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:7:28::24) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0137.eurprd05.prod.outlook.com (2603:10a6:7:28::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 09:33:32 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 596d8869-d2cf-4c6c-f840-08d7fbd7b33c
X-MS-TrafficTypeDiagnostic: BYAPR18MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR18MB29987C19522DB61A4583237CD9B90@BYAPR18MB2998.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn2/Ww1hD1U2d2uTZelE5lfZP6QDrs6Q5ca7wOOBOKQkWGxoizI/j6Ne+StUmSMe6cDNEE8JEDuhnC7Ka+uH3v8xgdIezMv1hpaXZYLrisapehQeqevkUNnxNmFqe+U2UEwWg0AU05uRb7zJJGnZahSkiekSHBs0XIN5h1IjbrMauyBruY5YZsPxL+lfofSGaM4j6EFRCAv01jsqQM0jOd+/VBuzKVvMVm0RRrBO1KrLOd766Hr3TC/0gNv0wJOGVkvyVylJKPTPo/N1kt9EcqCoyiQyJmnEd6zZNst/+6jSc/m4IQRtUM1mg2wtJSrHs10RyQkSlMEGxTD7xL//Pb7iEJnGqVQU28Qvp7LDOTu0LS1ASsDeR26HO6xhmlOmfzpDGQ4NVRllvH4MVmaAA3bRCJVbhqdON7ageQxqhFZv06euzTUlb2lYVjzIAd5O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(956004)(26005)(16526019)(5660300002)(8936002)(54906003)(316002)(66946007)(86362001)(1076003)(66476007)(66556008)(186003)(478600001)(53546011)(6666004)(4326008)(6506007)(55016002)(8676002)(2906002)(6916009)(9686003)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /flPOCU2WBGpyWz6pB1HmnuPRv6WyP2X010pRzgEJrcBtk9QxlUxnsxVUkyw6/hhBeq9jFiFlh/KcENAUa4w1gZni3kyxStlJJf9tA+a4tFqHjXnsphdBRdojBWSdYrOL4+5VL8Uj/bXuNf2a92WtMU0WjquKRfLCce3Rn1St2Znc/ld4xpuYN58/n6cRK/GAgDX7U0I48gyxnDcX62+qQtuOuhzFkny/x9Nrd3Hxq9u7jDDcFjuMqzJGXUxWN0iigplAyx/K0elhHEC4J9HV0iv92MAVgjcKYIcXgLlNlhkajlOxk4MQ92lMGu7KMf81yWG0VhDq3MiLgX5Ut/FKUWzLMsLbOB1z10/GBeo80mLQQsvtkdKA8+KZP1EbUxlO7x3gcbBXcjTkYfildP20Mr3A/tzXYwdn6CdbIbhKAtNR3k0zER7G67nk2zLB5epZAgb/xJ8vGffGd/aGNs7dGQXjlL/3J1xUdKL32H2/Jg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 596d8869-d2cf-4c6c-f840-08d7fbd7b33c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 09:33:34.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFFXpYjCqkoChjqd2JT2QENQuHLJuOR4EMcdXvCPpSnzZBPw95kjX9MvTnTFG5IdtdPX4QjZEr7S7IuLx6yCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2998
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23.04.20 19:49:34, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:58:06PM +0200, Robert Richter wrote:
> > Most iterators use int type as index. mci->mc_idx is also type int. So
> > use int type for parameters of edac_mc_alloc(). Extend the range check
> > to check for negative values. There is a type cast now when assigning
> > variable n_layers to mci->n_layer, it is safe due to the range check.
> > 
> > While at it, rename the users of edac_mc_alloc() to mc_idx as this
> > fits better here.
> > 
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/edac_mc.c | 7 +++----
> >  drivers/edac/edac_mc.h | 6 +++---
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index 107d7c4de933..57d1d356d69c 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -444,8 +444,7 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
> >  	return 0;
> >  }
> >  
> > -struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> > -				   unsigned int n_layers,
> > +struct mem_ctl_info *edac_mc_alloc(int mc_idx, int n_layers,
> >  				   struct edac_mc_layer *layers,
> >  				   unsigned int sz_pvt)
> >  {
> > @@ -456,7 +455,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> >  	void *pvt, *ptr = NULL;
> >  	bool per_rank = false;
> >  
> > -	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> > +	if (WARN_ON(mc_idx < 0 || n_layers < 1 || n_layers > EDAC_MAX_LAYERS))
> >  		return NULL;
> 
> Yeah, no, this doesn't make sense to me. The memory controller number
> and the number of layers can never ever be negative and thus signed.
> 
> And some drivers supply unsigned types and some signed. So if anything,
> this should be fixing all the callers to supply unsigned quantities.

mci->mc_idx is of type int and there is a cast here that should be
fixed. IMO that should be a signed int as some interfaces (esp. if you
search for an index) that require a negative value to report errors or
something could not be found.

So let's take this patch out of this series if you want have it
different.

Thanks,

-Robert
