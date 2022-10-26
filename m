Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C460360E973
	for <lists+linux-edac@lfdr.de>; Wed, 26 Oct 2022 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiJZTpz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Oct 2022 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiJZTpb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Oct 2022 15:45:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F9A65B5;
        Wed, 26 Oct 2022 12:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/xChWoRUiN4Bjckowf0vy+S80rfC6lH21sOSdxyaIz43nbiLr7ux09omdEv8IL2R/ihjbNzXjO6O/Zu2eVi+SIAgyWzLPbA0SQm+X3TYlmaf/9kXpRS2cd3Kw791aQqITcd31F/kmsveL5JGTrVv4wcEJkY0hliY5E7U1g0vwftf9s36BzryYJnGSJmvGhrC28iGMOU5tYiq4e7dNsYgAtP2w5wH1cSXon4SAnB3xFiQLCgqPdR4jXChFBaex5qgCRuRJKtoI3IsFEi8SyMxwoC7ibBvRYklL2J1bsn0YHaiskTzjlzoRwvXAagfrONX+ST5nreEcY2hmO9wrHabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ2xtJ7pTn8MLYMUFaB1zRBgo/E29ZS6wMRNpsGva0A=;
 b=X9cfhZ3QxPncZCaNC9yV7h52gXR303dOFeQzmzkAQMFQdolVm9pRxg5cq7WyJq4ZrgFNwVGgiDerbf9YljyqbJstD9qD9UEd91wwU/c2TMBQOJwuM0AD8WLp5oRp18B9FrHuL+OMJYTJeRE/6FvmHRrnEns8vyQz0sD9G3KO8JwH0b5IFaVhJnV91YanH2sazNf1RE3xdJICFLPkVsxBzAv0iDVzOGCJjnk6YgJRTPcIx1gEpEPenlFW1GiKLigM9IMxk1PnaC54FukpE0GEnH6qVytnjXiIvwPvxQgKTwpCgxtU/heZW939ucsBXRiCI+4WFaisOB84v8FlvnnQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ2xtJ7pTn8MLYMUFaB1zRBgo/E29ZS6wMRNpsGva0A=;
 b=tb2U9Vk+FptiT1Y3jrBHFM3qnES7rd8RLDN0RbaheDHnqm4sKKH/JKlXxxeizwvaFDOrBaA3a3rXXB01oc7SCpDqVkOnsGDxJ+wcry6Vrivn/J2a06B4SH76txHmE46TZ5HdujlTqs9uqMHqBKK2fcTa5zfAwr+xNxKTpe0fdDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 19:44:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 19:44:24 +0000
Date:   Wed, 26 Oct 2022 19:44:17 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Y1mOEfEM6MdnV8CX@yaz-fattaah>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
 <Yqnj88FPkZ6kBU7k@yaz-fattaah>
 <Y1kJCHBtatohj/JK@zn.tnic>
 <Y1kiNBh3/XBNe6uv@kroah.com>
 <Y1lUo08UzaqIaI7r@yaz-fattaah>
 <Y1l8nx1KnTFP1xKj@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1l8nx1KnTFP1xKj@zn.tnic>
X-ClientProxiedBy: CH0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:610:e5::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c9b02f-3ef2-433f-ca43-08dab78a7c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BF5IwsF6R1+uoVDSDVz9n0V+MYlGkw39UEzdziZ07pMhnCuxcMLTyFdwFZfB51NQWOGq31avwpdrifX5zCf9KJk4w5S8a4m1xQQTeg5C1G6ZPNz7XV89vCxpiD98fIgyA1toYY13Vd96GNY26x8LDfXvNx0k/MAyB6XOKbXpEKJ+0T9bqqKeYnjTrwnnap7AQ3y39YEN9ap19n2EqaVsG0BIXQrrtySLTUa7+/xhTQZysO7HVLrBAbOCYjSDJtEumPd1z5jX/7ZdJU9Ms7csLkCSOc/IdV9Nqa04SqaPwHlMQoAWCKssZQwREKJ0Pe7F3rpTjUcvkcn4B11QsXiBl1XXft/xh2mC2DagD8uZLmLT03X3NGG4tGdVhjPeHC87gkzB4ROEDlx/ZNTA6dbxesHSxgXr1nG9KkTNPgtyGQb8zLUJMyqOi+zXw4OWGwW1gqqiSUF0eO0jT85wmwAaMqqvTX3meD/GQjY3usYPhcxkTLrIbnzX3VYmCVKaJqVK8e26lmbagnN5FjdEZdM53YoMxoyzjJiv0/TmYtBiBYKxJEm8Zsp9C4L5gkhCGdFnInknFRiA53oQTdTGPaGrGLy6YoYIKZrer3zqxnZPY1x8orj/09jLXlnJ95Pqaddvet72+P85HmTAomL3zNd5uZslcJ727GS7t8OyflKySKRCMG9OCP5ED1gFX8z5OQwu5LvTS61LmSCOGkrEGCzBVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(44832011)(6486002)(38100700002)(6666004)(66946007)(41300700001)(66476007)(66556008)(4326008)(5660300002)(478600001)(8936002)(6916009)(8676002)(2906002)(83380400001)(33716001)(6506007)(86362001)(26005)(6512007)(9686003)(186003)(316002)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RID6/BpR2RG49twhcCv1MP5dBM7E6C1zCQMDwIPA6R3jkUhKFqjeG7vq2gds?=
 =?us-ascii?Q?k+zdFi/qTgJXCdBBic4CcC61Dt2JUUBZ/jibRmyzxXq9zNCdp4tT1MMIRdBp?=
 =?us-ascii?Q?NxzorvXZ5VOUc9Xud6g7cDtfgJfisAkIDCsHCICVcOPiNwq5JeCgGfck5aYS?=
 =?us-ascii?Q?8Ha+UEaLMy3oSdnTJqSLmSCgyPc+0wlekO9xjTgdoVp+Fi3hUnuIMmjBrZ+z?=
 =?us-ascii?Q?xoFRvpuCn/Li1Efrcbrhnm6G+m2ZtSXQlbmgqOCkEL0EVzatXRR+IWcx7/vU?=
 =?us-ascii?Q?rvf7OiAViK7MchohZzZ/IH8jC7TTF+t+U3pMlca7Xy9wUqS9Y0/RWDz9nnpE?=
 =?us-ascii?Q?dv33GmEeY+5rrK4WziWMtocdOVOEpr1cjWoP3C1q4KIggxZ/kAZ1G/aEusSu?=
 =?us-ascii?Q?vmtZSIIQ/pqYWBHUprOPfhnYssRZITJRRf/rOX9CpuRVu+sxR/C0bktbSDrf?=
 =?us-ascii?Q?hBuJ4+E6OXnRYm+RNsFcnWb/zZI+pDOrWvJK1VvwWmMl1NSyKq6PwNoBU7Da?=
 =?us-ascii?Q?raiSz1kJ+O5A1oPJID0DzBf0RbJkzCMAG3YFPUr+BosHZg765URu4/sCXHUF?=
 =?us-ascii?Q?mprqB/6KAyJgwR4jHF4o8giIxRHtfKhPRdgc72trTNCIyc20igdJyPSTLvOP?=
 =?us-ascii?Q?5uJChOdKVKZrV8rBQSYtDMeD7q4YdaizkUcaIGOuZlQX7XtoOnKEuYmsalOz?=
 =?us-ascii?Q?m9DzlS0QFaT1ON0EwyuP7Zd4KsXIWpFCqW+0DbdMl/pEtr8YK/9TcncCFWs5?=
 =?us-ascii?Q?xkPETKKFO+jz33/IhkVjkzx61xYxeHMM7/eszZDP7JJ/AZUoWw5BnNSUWiaq?=
 =?us-ascii?Q?Lsu3tH9IjL+BHerGvCVY8+F/BEBdMnuWAc+MCuWfiwv07vGy3ySPnIWB+FSV?=
 =?us-ascii?Q?KT9EIEtbXNNPyRxOhVuaiP92x7lOMORQOIbSdwqtNQof0Y588yNbZyNE/bz8?=
 =?us-ascii?Q?JRZItuIQpiqg+OHd50ybjfiNzqAMlY9CAuqkcXgPpgMvmAB+BXipeG9BCcYh?=
 =?us-ascii?Q?J8Iw7KI2ZZcA2zui5J1t1bYJifnZAXSRr4yoGzy3ZcjYEVpiiH4IHUM2T0uH?=
 =?us-ascii?Q?wyHH87wmkdlArUn40ct/+b1a0HiD2OzFAjAWFJQv8ynbDgP2z71AhxGd+pRC?=
 =?us-ascii?Q?zH8jXUClXHVWdrp7Zp7gkn+BgqKxnQh89bq63dhKlQydVCYpcuxxy9ho7Bpk?=
 =?us-ascii?Q?weMVdyyihi3qZorom1tRq+kPaWE9YF6oI53Z4Dck49DOJFg/sP9Xh1yrNZ5h?=
 =?us-ascii?Q?vYFuzyNaNBvwKJ58ofxmdyB1cisntnNO9wk5HoLTik5/SV7fON5GkiH9D57C?=
 =?us-ascii?Q?uyUny6Q9wNz/OcnJe/L5mhJDVvKkXgjYqkQhMOeULOSpkfx75TOgcXdSkAmL?=
 =?us-ascii?Q?nDVhAvE+y7yeden9KGh0awe6wsfUQ9AWdycC0e19MJaw/DKYRMKcQ86KpyL5?=
 =?us-ascii?Q?RKz2XF5OsmAn/GEO4Jg58BPHpeg8nqDXTPISPoJ/3X9ca8mTRZLq7DxIX2e5?=
 =?us-ascii?Q?oyDGegNwYnPjTghrEkcdaLScWaldxHq79uqL3rYE2Y8egVtMuPHrLa1e/pb9?=
 =?us-ascii?Q?M0HgkZy+9r6lzRfxd4Ewxriq6A1jBix8FGEO8IaE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c9b02f-3ef2-433f-ca43-08dab78a7c4e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:44:24.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EnXTbzXkM0olI9R050U5126VoffEkNXxqoQNM71hYValXhU9jeJXf03cSNt38sT5GDHiG1oWCtgQkrA4n6r3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 26, 2022 at 08:29:51PM +0200, Borislav Petkov wrote:
> On Wed, Oct 26, 2022 at 03:39:15PM +0000, Yazen Ghannam wrote:
> > What's the issue with my original patch?
> 
> Do you see it?
> 
> > @@ -1258,10 +1258,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
> >         struct threshold_block *pos = NULL;
> >         struct threshold_block *tmp = NULL;
> >  
> > -       kobject_del(b->kobj);
> > +       kobject_put(b->kobj);
> >  
> >         list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
> > -               kobject_del(&pos->kobj);
> > +               kobject_put(b->kobj);
> 
> You're basically putting the parent as many times as there are elements
> on the ->miscj list.
> 
> Basically what Greg doesn't like.
> 
> Him and I need to talk it over first whether my gross hack of grafting
> the bank4 kobject hierarchy from CPU0 onto the other CPUs on the node is
> even viable so stay tuned...
> 
> > I think this is the simplest way to fix the current implementation.
> > But we should probably get rid of this kobject sharing idea in light
> > of Greg's comments.
> 
> You said it. :)
> 
> Or maybe do a better one.

Right, so can we do the following two things?

1) Apply the patch I submitted as a simple fix/workaround for the presented
symptom. I tried to keep it small and well described to be a stable backport.
Obviously I wrote it without knowing the shared kobject behavior isn't ideal.

2) Address the shared kobject thing.
   Here are some options:
   a. Only set up the thresholding kobject on a single CPU per "AMD Node".
   Technically MCA Bank 4 is "shared" on legacy systems. But AFAICT from
   looking at old BKDG docs, in practice only the "Node Base Core" can access
   the registers. This behavior is controlled by a bit in NB which BIOS is
   supposed to set. Maybe some BIOSes don't do this, but I think that's a
   "broken BIOS on legacy system" issue if so.
   b. Disable the MCA Thresholding interface for Families before 0x17. This is
   an undocumented interface, and I don't know if anyone is using it on older
   systems. The issue we're discussing here started because of a splat during
   suspend/resume/CPU hotplug. In disable_err_thresholding(), we disable MCA
   Thresholding for bank 4 on Family 15h, so there's some precedent.
   c. Do nothing at the moment. I *really* want to clean up the MCA
   Thresholding interface, and the shared kobject thing may get resolved in
   that.

What do you think?

Thanks,
Yazen
