Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D213B1D934E
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgESJ2U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 05:28:20 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37460 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgESJ2U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 05:28:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J9KjKG014165;
        Tue, 19 May 2020 02:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=dAtepPu8G6r6uXEJR7lDvL6rxhZiQKv/x8Lg88kTCeU=;
 b=j7sK2z8g1E7+KBi0ZzAYKh9XSe2XZDiihigBwC/5crp681RHY9QA9qmfbF/LSX3/KS58
 2EwM7XnipTl246Dc+QflrBOE9IMmnvexOhZ2biY7PjKx7Cz+ZvPkmRmDd3jPmU42duV/
 bPMTJzqbJEQchwEgYIfwd+5QuUbCqkfe/qFZC/yVQ7Xg1yVa3e0Ry59EpxdoaCz0/1s2
 2yA+J/2ck1nmSxnT55GjHaGELQwpFAJLS8XuIDhGIFmoLWUpm5tHP0/pwUbpn01aa1HO
 J0Sfu5Ys23auvUKdykMZU1Yzn1C0hAeJs0vIvgnQtdMV7vevpOgyjpWDUnDVaem1s3BM kA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2q9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 02:28:02 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 02:28:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 02:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J69OcseuV2ekaqHkNxP9EA+D2bsbbNTnbHeq26kn88vNjJ8dUNJIhuNw8B04heyHr974jvMlYr60DrCKx9D6bsvKh1DyxBO+tAylYzj1CEFsFmwC/AFQE4DvFEzdt46UP6wg/gNeDX8LJaRh+o/G/jRmh+o2qjIyxppRsAGSdoyFNOiPtCFjArOOZxxS4BNiMoie9F2yc5ykpHfzh2u6xUrjDmX43cNKAO6ekqzxVmNrYSKr8fofBwLjLBmQ7xwtwEPYsdHp0OtVPRRkRppRZuaLM6+Tb5FC6151l4/WNTPHbjbqDHXg8x/JcKvGA/On1T5Rkq7+Uk/kBCv4W401+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtepPu8G6r6uXEJR7lDvL6rxhZiQKv/x8Lg88kTCeU=;
 b=BfRN0g7ckAfgbNOG4rMyA4EAAjEHaFOAJWI3xZ4kwbFQ4q7B4ePF4bUbQbr3ozNMQ3fdJmpEq5/d4MB2NLPijAVnFe0WOOSd3zITTjv7gUL5lkbZxwoPGDVcdAa0PAN20MMRycJ23VQVn23QZcCEyPFZL5H/gbuh1iwxSjCE5NPRonoQv8Wl6ahJv4tSap5nAOQdo2mcpJv4vLW/0nkdMMQq0ZtaBZ272aaZ6FfQjaiqRSLXUwJHaAhx+Ckg/WhAcnUa7qP2+yFotUn+Xx/TToxNQI22fHj4PM+KKxRIO3Gk0WbSTatsEsFj12zfOZQav2RshFXStKKD3ZFdu6FmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtepPu8G6r6uXEJR7lDvL6rxhZiQKv/x8Lg88kTCeU=;
 b=qk7q17BuHD1xm743AXOTS7cE6E+1eUBpbxL/Ind3Xt7j4zCXAkTXm9v/xgLr4G5V72siDX9ISueX02yaxj9WKmt9oFso5xb5+dEiOjl6p3WruehTL3YVQM0TYsu5iuKsKqoHO4T0rghAipSB26RjGtyyl0oeOwViBOTSJQONQI4=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2534.namprd18.prod.outlook.com (2603:10b6:a03:12e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 09:27:58 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 09:27:58 +0000
Date:   Tue, 19 May 2020 11:27:48 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] EDAC/mc: Fix usage of snprintf() and dimm
 location setup
Message-ID: <20200519092748.zalds3reudd22nky@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-2-rrichter@marvell.com>
 <20200422205243.GH26846@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422205243.GH26846@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::24) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0502CA0014.eurprd05.prod.outlook.com (2603:10a6:3:e3::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 09:27:56 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d7ca3f-e942-4821-074a-08d7fbd6eaf0
X-MS-TrafficTypeDiagnostic: BYAPR18MB2534:
X-Microsoft-Antispam-PRVS: <BYAPR18MB25343AAD586386B895AE54A4D9B90@BYAPR18MB2534.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjQJZLxhYwPzGpvmoNZ7hqwmcr53MdEnvczbldmWLqGJmfC9tMQ3yoc1WltZOpUvUhXh70SjVoV9xypBNWXZrXg++4c7YG2jw7KbIV3JEjw3Ua3qDuxCM6QAxbrqAH/yYZt55V33hAX5Q0O8bSPVtQKZXNIUj1qzFU12ptJum9BCjHJluxgSZXJSi2T6uBNYtP5vZ7wFF/6N8TaW8dDkcsZBZt0frNfX6eJ3UhUZta1OTJJ8f5WHfyZZHU5ZFlOjhTofiXLEuvPKByLz3nQNsz0G9swqPc3W6cih+x8RnaiooxyqIZ4yLvlB4WaP9LqkhqaWMJ5xYtrmedXdjuq2n0cydxfUkl9lzOozGwtegmgeVqpkJvd5YiLrfL0VfMg413xo/+WqHgVjHr7+Bn4gU12h04eqhdSYh7P74WPLTGL8snc7/xwuksymcpAZXHAN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(54906003)(316002)(956004)(26005)(186003)(16526019)(53546011)(6666004)(6506007)(1076003)(66946007)(66556008)(66476007)(2906002)(52116002)(7696005)(86362001)(8936002)(8676002)(4326008)(55016002)(9686003)(6916009)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nr4iAAzEFHfgWYI45WUQvYVw2un8HnZfdaXjnKXPCMrQ8g+QfEiHML2MmUpuCOuAV/Hvjihvp/GefJ29lAG9e2zjOTTZb9h2TLaJ4lzQ5tZ3TPiBP3ageej00m7SLZt8zW4vCbsEGDL9dO/uXebuY9qSg4909VNhIkQD700SPJdVoNNbCYCSXBZgIjq3Jy7iRwa1aSl38i17Qyalt2aCW4E9Lflp424PJAp+gspEWwuFRSASjMvWILGBX6Qb6jKRlBkXVPjWUHitWO1Npep2YkzGb18CVa+Mrg1oSl2y68Yik7XUW+cZ7U+TbWT34p5PURj6LXLhj0paBycJLbl7i3AB1TNdNKf+2zszVeIchYoNjAYYcYr7Y3cKwXOTljAd1mpb3iTtWOvHWoJO/OGXLiKGZ1xBsVE4YMnOvTK7FiU7QcaOR4DHPu2ylSRDRLNnkefyluzYev6TUp0jkeR2NFayJAxUOz1N77G+vjs41YU=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d7ca3f-e942-4821-074a-08d7fbd6eaf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 09:27:58.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5Wsk4d3VSOzibPvGQ7iiTRTxx/xsZSUVwyOrn5i3YjegcFdxzbTmYA4FGRVEB3Af2vtwXC6JEhPhVwEsXfolQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2534
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 22.04.20 22:52:43, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:58:05PM +0200, Robert Richter wrote:
> > The setup of the dimm->location may be incomplete in case writing to
> > dimm->label fails due to small buffer size. Fix this by iterating
> > through all existing layers.
> > 
> > Also, the return value of snprintf() can be higher than the number of
> > bytes written to the buffer in case it is to small. Fix usage of
> > snprintf() by either porting it to scnprintf() or fixing the handling
> > of the return code.
> > 
> > It is very unlikely the buffer is too small in practice, but fixing it
> > anyway.
> > 
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/edac_mc.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index 75ede27bdf6a..107d7c4de933 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -130,11 +130,11 @@ unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
> >  		n = snprintf(p, len, "%s %d ",
> >  			      edac_layer_name[mci->layers[i].type],
> >  			      dimm->location[i]);
> > +		if (len <= n)
> > +			return count + len - 1;
> >  		p += n;
> >  		len -= n;
> >  		count += n;
> > -		if (!len)
> > -			break;
> >  	}
> >  
> >  	return count;
> > @@ -397,19 +397,19 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
> >  		 */
> >  		len = sizeof(dimm->label);
> >  		p = dimm->label;
> > -		n = snprintf(p, len, "mc#%u", mci->mc_idx);
> > +		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
> >  		p += n;
> >  		len -= n;
> > +
> >  		for (layer = 0; layer < mci->n_layers; layer++) {
> > -			n = snprintf(p, len, "%s#%u",
> > -				     edac_layer_name[mci->layers[layer].type],
> > -				     pos[layer]);
> 
> The edac_layer_name[]'s are single words of a couple of letters and the
> pos is a number. The buffer we pass in is at least 80 chars and in one
> place even a PAGE_SIZE.
> 
> But in general, this is just silly with the buffers on stack and
> printing into them.
> 
> It would be much better to opencode that loop in
> edac_dimm_info_location() and simply dump those layer names at the call
> sites. And then kill that silly edac_dimm_info_location() function. See
> below for example.
> 
> And then since two call sites do edac_dbg(), you can put that in a
> function edac_dbg_dump_dimm_location() or so and call it and not care
> about any buffer lengths and s*printf's and so on.
> 
> Right?

The aim of this patch is just to fix snprintf() users. Anything else
would involve a larger cleanup. It is not only about edac_dbg(), there
are other users of edac_layer_name[] which implement similar things
that need to be looked at.

So I am dropping this patch from the series.

Thanks,

-Robert
