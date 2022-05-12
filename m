Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D92524FD5
	for <lists+linux-edac@lfdr.de>; Thu, 12 May 2022 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiELOT6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 May 2022 10:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiELOT5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 May 2022 10:19:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFADD6C579;
        Thu, 12 May 2022 07:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrdBC9hVDREaxvPdNcx6mdgMuzokSDu/R7dZpCXMfcE9HQeo0IqugPvtqAg4Z7TH1pf4GEK0hOp3zZOps6eOFKwF4XeDnh0N0XBWiGSRcmjDXmNJA5qKKUQ+LNK6sHWcgWVDPo76LopR24/8QHYoxp86vIEEAPrngWB5WsBidEkStpj3umiRmiwg7jL1qDs+J+sQh0iGOFJTPX8ZvgVgtHdoIu2lLc33LqbvBsKCK0cVJl8Fmj/XVVW4LUQsuynUIamqJd1pCjhTVub+x7KtM26/RR/7W/baf2SeSSgxqAL71PrxI3Ch+6gCYEYi+t5ZsQxDqJU1MJlb582LSXyLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEEKqZ66i8J/deiIvFLlQTYvptTYjkvIsRwN5gDGHxQ=;
 b=STLO3Lwkt/DW6AImCsnC+sz+tIupuunTrXAT/yFJgIoV261MU7fF/KEFtrjbhlZKvMa+nHx0vjKWGqXbue9R/gqwrgWsW4X2I/1LPgAyTpIQx8EGMecKLv9ZV87z2rngx3lbsuoGt8dctoNxhTaTr+eaujQAePXMem3a1TpNn1p3Kf8jVMgTRcm/RDZkBZGfwmEKczkSGZqy6iJ1UZsloxs2DTIqQsRUOR0y+/88BwB4XxigSAKTKf0DgRlB+rytNq2ugD2i1Bn8oPjkVxAaiPcA3lbEUffeL+526P48yci8rIIEqDghBflB6qYheSHahIK1pYhUBGTPyRbo5Dmpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEEKqZ66i8J/deiIvFLlQTYvptTYjkvIsRwN5gDGHxQ=;
 b=J+pBkuOdApOlME1CIfvmh+zCicDZgFH6Lrm4yQm0Hi8NEmdc6I3kaT1PLAwcP31M2Wg6DXGg4j7HvVKoWUUBo8nWE3HImGG9Z9wvcaMK1PSeiFl3PE4ugV9jqmFh0pMi2aUvgPaL9j/DFFL31zZmJzE4WPCclaz7mV6x/8r8wTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB3928.namprd12.prod.outlook.com (2603:10b6:610:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 14:19:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928%2]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 14:19:53 +0000
Date:   Thu, 12 May 2022 14:19:48 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 02/18] EDAC/amd64: Remove scrub rate control for Family
 17h and later
Message-ID: <Yn0XhDwRGB5uBY6E@yaz-fattaah>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-3-yazen.ghannam@amd.com>
 <YnuPU41KWLer9d5T@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnuPU41KWLer9d5T@zn.tnic>
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449616ee-df7d-482c-781f-08da34227b22
X-MS-TrafficTypeDiagnostic: CH2PR12MB3928:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39284F50044D33EF358CC1A9F8CB9@CH2PR12MB3928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 503EUOq3zWQBrfYI+NYyS2SW3hw7/ucVt5P3mRi+lbRgGsjT2BTnwl7SOKqag4Cunko8SvCh7NmlqilS+n+q7lxISyf90AA8NE3LU4UPZ1Tq3khX+WPt5aPIBIwq+5kKhAUKDK9kB1V4ih7x9qhsbTluLisdZcxUfYWW7B1lFnamJhV37RSCxlMoX39JhQ/cBUE+hdV0snFIynOGl/pjeFpcuwV0YQyTFWkIF1KLUx+e+0MEhezaVhY2Kz7Lvikzl0Vmkpe3wAjHABwcOiiyc7YOv4FwIL6gfJ6utsrIlI9aLIWkt73HA7wPJdPR5j88OyyXWh0vBwMTXmacy0+OEvRvTKtEIilBiAaBGSvB/LXC0wHLV5Mq/uApj7QEEEez0HIcgJEu+U1NqU0XSHNglbCvKoKU5mgPSv5BQgFo2NprmQVHA1aT3us/xJj9Nkkn+S1Vv0O2r/5yY4p5WAwKxrmreYURGDjBLrR1UL/9vWflmDgCFmeikJ2x8SF73SMn5LOPlu9+tRJQWUC91tN9yAWCdOq3sK16to7kHUdt0bmnvqLYiyzf6zMILCA5lZ7uGXFQ1ozLK3aqN3F7YkA44e0E4vkYvEM/bcrBIMKvf1NUbFnnO1izw/hYFXm1QabV8zWVGI93arSc6mx5RqKPJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(186003)(9686003)(508600001)(2906002)(44832011)(4744005)(26005)(6512007)(33716001)(8936002)(6486002)(5660300002)(86362001)(38100700002)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(6506007)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjbXR6RDNrS5tquzpti0BxxmUTlWnDas4wTrU42xkkU9q+GFF9Ndgrg92/h7?=
 =?us-ascii?Q?K1yc2HrNT7nwUcEjUY1UPFjsL7tB/UDnam4kUNRzRXIB6DzXYhPHU/eAAVXC?=
 =?us-ascii?Q?81SzlbY607YmqtkpPeKB2kNZ6XJQ50i/QElzx+LFD+WViNoyRnirb6ZNSPvB?=
 =?us-ascii?Q?EsKwOT2MtMw+5yb/RSSdHNRbjPnC9GffbDpgHrgo7Q52j1kGhXnTsbhGc6KP?=
 =?us-ascii?Q?TSN8+IAueHB33vlsPwv5D5uldYtkEXP9bZHTUt3ex/c7ko2S1jeay9q0pvme?=
 =?us-ascii?Q?6xOm1efXM1a5743/rzSoEc755F2aI5ctWhyw93UYt7HRDohKtcfg1B3FLopZ?=
 =?us-ascii?Q?rlw54Xw712EdyFpYveQchTs2//VtjU2oknz5ROTmemETRKvFN6HnndQvSB1g?=
 =?us-ascii?Q?50FTNuw9Acl3aaZO+6UqCrnr8owPGfmkub1HfQn0Db00jJhksWkfLFp3fWmb?=
 =?us-ascii?Q?qq0LXjV5nv8JM0ISl7bDOzbeUS8wwo2dYSkoqMItdDAMAXr3hO1lgF4LmyZA?=
 =?us-ascii?Q?SG2NWgSsBKcvPgQjV13M/yIDXt6OuiBUljUEm1bCgHd1RHVXxIPFJJjB2Ibe?=
 =?us-ascii?Q?95R8gxEik8XFBDuxxHELuwBHm0fbi+s7QZeJtBhMOWAR/vXQ2A4JK6QxPQRf?=
 =?us-ascii?Q?ChvnAFt9JJ8emPMsZWkR+dvnCvl9XrM8OHOwwD599j4V5BCQUh/pmL7W943P?=
 =?us-ascii?Q?CQdy/zAEj87RadfM4US3zceQLwoPKa8Iu0mo6lRj+giAhhOHIFNe1zCNqx4P?=
 =?us-ascii?Q?YqirNA0y0Gy61pIoVh66xnNFfPf+07F5BAYw/e7Ygh0DW5h3WBK6qeLHW9dG?=
 =?us-ascii?Q?ud3NUOS/QlqiyNyYZoHPSfF0iAYuwWhYNbA6yN0DTzgj4ZX/5/Og5kI++DAY?=
 =?us-ascii?Q?gyNrYVnmXxqABS14npQf0FI+nhhCjYYX6algiZl4nekaZlgPOYCbOpCqJvaB?=
 =?us-ascii?Q?ChVQZ7ugcBMgEa6YDR3O2qK5DlWQHxackhYtpACOkJTj0KZ07/Z3Lbdwu3sn?=
 =?us-ascii?Q?+7YqK1LviVRZnFoJrHY//YQxECRlRVRqbniy+jAz5Cl7cp/xDWpOZt1+RLxV?=
 =?us-ascii?Q?nWv0w+sKLXfnqMbOStZaKXkpUeuO2P9S5M8HRyc6LtUc+9BPhsjYYhsFVNwb?=
 =?us-ascii?Q?S/q/S3zzU9OIK0rPMiIe/30CD/HBRKBB5sHrz+6SUdXf/7aDEFvhnALD2AZr?=
 =?us-ascii?Q?aZF5bbvaMXsvnSqiKOT8+yb+02QRB49sfie+jfvB8BlVPOksWBTycTE2qsYX?=
 =?us-ascii?Q?7V/640RIgwfLL8MlG9egh+9TKuUOxgwcV+2ZthP9EUTEnMr7+4zyyK8225HD?=
 =?us-ascii?Q?C0bzGPa8pvu8rfZEsDJD0ACBwVvDjSMXvBF4HS80qIBMnIMBdQI98kcPdd50?=
 =?us-ascii?Q?G7vDd0Th/5ESzjnSV/lTE1xkbYkeDq9odfUnMsk1Nnsyfatj0316k6K4jk6Y?=
 =?us-ascii?Q?z++SoinWZUfkdp4sqcwG3bR/gEivuw49cFkUP60h9X8WdPBpG58f4fcnsRSt?=
 =?us-ascii?Q?ka28pgwmgllLssZdy/9AlgbgoAsUXzI9guCGQzYKo+yZCtOV8G8rpX29GwAR?=
 =?us-ascii?Q?Yxv/lWaCsJ8tqMeoDjYfIWt7tTEnHmbLX7t7vH1KaoWDZXo+urDxQdGV+ROD?=
 =?us-ascii?Q?dKzEx8eIex53Fps2FEBPh8mifhhquu8x7Gumnza6AVx90a4gBQvZ/tuDnhWl?=
 =?us-ascii?Q?HeQ0wqg7BlKHapwD+REFhPLijWFpKuBsLJJFs3ox7DNMf99k+anrvZj7lZdt?=
 =?us-ascii?Q?h7fZDXILWw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449616ee-df7d-482c-781f-08da34227b22
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 14:19:52.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASKFfo9FHugxoe0uujxFxJvMPmb1QFgOTjiwfFChPKc27WO68QmTZX7qmZW8hHWSYorWrGWqE/m4kqAdbDnEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 11, 2022 at 12:26:27PM +0200, Borislav Petkov wrote:
> On Mon, May 09, 2022 at 02:55:18PM +0000, Yazen Ghannam wrote:
> > @@ -251,6 +234,9 @@ static int set_scrub_rate(struct mem_ctl_info *mci, u32 bw)
> >  	struct amd64_pvt *pvt = mci->pvt_info;
> >  	u32 min_scrubrate = 0x5;
> >  
> > +	if (pvt->umc)
> > +		return -EPERM;
> 
> Since this function is testing families, it might be more
> straightforward for the check to be:
> 
> 	if (pvt->fam >= 0x17)
>

Yes, I'll make that change.

Thanks,
Yazen
