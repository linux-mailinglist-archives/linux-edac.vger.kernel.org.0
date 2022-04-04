Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A044F1DBA
	for <lists+linux-edac@lfdr.de>; Mon,  4 Apr 2022 23:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiDDVlF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Apr 2022 17:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379763AbiDDSC0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Apr 2022 14:02:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428A36B6D
        for <linux-edac@vger.kernel.org>; Mon,  4 Apr 2022 11:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy+B8UOfw5extAgEchsq5rAINhirR8cPqiRb3LHRud9dyY/PeqDPrruDBQSpVq4cgM7yjIR3srLgqgYhz7JyZuw1cOK4KyGtMI603z2vE/YVJTVjKgHct8Pu6FyDdkPyBxzzxa6uVR9+/f3OvKCOnGpJUyFdglb2Iu9J4EkrsxLRs0zyYN40LQUTS140oMLt8prF4cni5q3Vk1FI/myfYbUC0rGiBVK+OT4NXi36vmjbyMawGKvELNn5js50Uwx9wKK1wcmg2+ggPeXF33g0d+1Ely9J5hga8JOexU8tacyC0hBJmh/OBnT10wyfnUHMhto3jY/2hpGsr4PtQMv30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LDOZvghJOYicgW+ia5UJA5RyeSuXWgudAb8iqswNa8=;
 b=a7swbyHAbFdv5aD/Ke5RLtvZueVZMK7aXCbXoWHEaGvwrNZftkzINRgblhbkhgW6HAhar28z029KJzo3CjQmRjVZwKKS2qPDb8UcAEWr+JqkndZlKo1Oju1TAhi5+BMCFNvrR1jP/YO/XvpCoDqJQ6CjZ7LSLGZm10n/IJMh5vQSZxz+xUIVE5lxPjOXgrSQFYH9or5u8Q89m54DAOuq17sCkDsb3dEzHSo3nb3Wsc16QLXCkN7Hlarde4YpzHNDvHh/tELEb0mUwh7rccQwN3horRMW+TQEwtzifOUm+A1e1kEeIHcCB1ryoXXEH5+bGae35OuY6dD1AqOFkf3/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LDOZvghJOYicgW+ia5UJA5RyeSuXWgudAb8iqswNa8=;
 b=INTp8uiQRUpo6XqHX7PWEXLbnKtaaoHEXNtceDaphLON1Z9DkFVCRIujwmIMlrwiZpuqRM8IApbk65YFJ7IM950BAgSNvJFaI24rSAJ4Nb8QdW0LCsDXbr85tIQAsKZKJr61bhKWTxxJpval4JmPmjueH+Ahk/8TcER6KC2Ar54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:00:26 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:00:26 +0000
Date:   Mon, 4 Apr 2022 18:00:18 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 01/14] EDAC/amd64: Move struct fam_type variables into
 struct amd64_pvt
Message-ID: <YksyMj8mrHJUs+F7@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-2-nchatrad@amd.com>
 <YjtWnqnH7ytG2K/j@yaz-ubuntu>
 <37449efc-1157-1d48-ec2e-726bf6c7edcb@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37449efc-1157-1d48-ec2e-726bf6c7edcb@amd.com>
X-ClientProxiedBy: BLAPR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:208:329::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0869705-c02d-4666-a86f-08da1664ff54
X-MS-TrafficTypeDiagnostic: CH2PR12MB4230:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42305D139A7D8F3724088D4BF8E59@CH2PR12MB4230.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UN8fksm47DGgW50/BSe6sD1R4r9r+Wf1kIgoSxTrRHrntN4Z0NqMZDYS6Q511GzNFDDlAzLRkHvbOCEVXyF3NMdSQmXVHE3/qK5iLwNCYHkDEQC72ZmX0FTXvnKpL6/9ZFpdifExivjcu9vwDPeYRtAGjOoVnS5PrDmzpDtUrjMub+Wck3wM/0xvPf4rYQpiTPEHDYaM+FwHfoLUtxgOF9oNgbDkkdwEX/owbiO9Mxg2dlQNMPZn2No6WORLJCinXqDI0TdsXSquHu3duKQNaOLsEevwXeKMntuwtVFvspya/8aowGElROaQAcDb9ULDv4AsD2uCNNFIViSSXZtdOsKTrPy/ukG47V04arUKV/JFB738ctlQK39ehiffgmqnyDyW2qppgHxwIvntGUo20YILwIrBdV1VLhXV1XVGu24fBAAUuirYFlB9hZZiYH1Qqel3AlRIfTGRJr3ZV4mYwFYegQMWCgcqmQLYfm+mVDrPLD3ZaDMXJaSVdA9Ab2n79Kp63NIwqUkCvtFe6VH9WjM0LAFctTPzVMWlrvYf4XyuodniFnzxjCXjzmd1b+A4DsQGVzkt/HNcbRSXYHVcyIEtuQQ3+1AkgRE/52wDEPK+A1o15/BKi2AmGFMl2JscQLYZ3+/XJy5Aom5DPDzNboPOMvfLA5Pdj7Ss/hW3FLCxekEeVtj5EHoQUCvSExx8zVZekY0vh6axaYYTUfvUuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(2906002)(83380400001)(6486002)(38100700002)(33716001)(6636002)(8676002)(6512007)(6506007)(44832011)(4326008)(6862004)(86362001)(8936002)(5660300002)(316002)(66556008)(66476007)(66946007)(26005)(9686003)(508600001)(6666004)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?if5LgFqG0Zuz8Pb2Wlp44PIraOwDth5yEN3yzr21nU4C3r61ta0Z3aMttW?=
 =?iso-8859-1?Q?4JyzoedciOXG/Ay+KIaUkq/tMjhVx4yg5GI7s65Fhoj7bvxmRwPe+1IMvh?=
 =?iso-8859-1?Q?2az+d4teFXMRLefNZ6vIws8K0XL4Eu39w6Fg4USFEZadOctsNYB3Pfn1Pz?=
 =?iso-8859-1?Q?0PrWiUMC8jo/x5/2Bwxy2//X0U16hWP67zAz0F9FoHBWxdsg3OybUV7BH5?=
 =?iso-8859-1?Q?hf8+Prd59xucjEb6rsmnvKQnKCLAlPaKyBbmioHSIdaybF1g45w+ojVrPN?=
 =?iso-8859-1?Q?8UPiGw8Y/+ZMrzh0vZdOEIWMqJwT0JYQZuQ7DP2GgaXl0Onn8jH9EXbelO?=
 =?iso-8859-1?Q?VHClEkb/FUI94aHuLMJakiT8niuw3TYsVHDDls2nhcX/RyZgQDKBt27kPh?=
 =?iso-8859-1?Q?LhX3nXv4hCjy0UrVJc4v86aE4BaJHHHu1pNXIuDUv8vuoytM9YC7aizyNz?=
 =?iso-8859-1?Q?vc9ivcIqeozoGgY8RhkBCPr7Xj7pZwpuAgmwRHi/QPomBGAlbphdwjlxO8?=
 =?iso-8859-1?Q?0RVdizXARXfmvzZRP4cv8QZnjr4a4j7KluByzpW9XuAvJu9IQvQtKsN6SS?=
 =?iso-8859-1?Q?0QQnE5vXJgqqFxBz9cw0F1ANWJkeau+wxHj2sYh0+fllKeru1CF9MamgBb?=
 =?iso-8859-1?Q?54bB0CiBXEFjrg8Ern+RWTAZdvLBx8RKrxx2tdPZi7/LnSgs70j7XBJlWV?=
 =?iso-8859-1?Q?I+Es8z+CKRJiSfoORuroLnuydY0pcnoVaEAn/3a7ISvHjWO9KvDcEOneVn?=
 =?iso-8859-1?Q?9sEQ28UxyAs7Tkby9faC+BcrYk3dYUA7F8v2CTM0H8zSzlHHvvgKy9Bk9X?=
 =?iso-8859-1?Q?oUr8/W8X9/n45vVvCk2QQBp7hljJyuxumYm6i8sa/xwo2CpsCdvMCM2Mfy?=
 =?iso-8859-1?Q?wsP6G2NcRaxdUookXq6DDtPkR0ejapKkvHL8o3sHCEKsGm20vUMAWQhSZ7?=
 =?iso-8859-1?Q?S4Lu4TgbmV5X2QFoVMh3LVMqymfxVa/dgJJOY8zfztkK92sqsip5F+mXmT?=
 =?iso-8859-1?Q?5S8xi8D9n3ObJuCY5rRUsnI1pf4/YZgS1nmp/BQltvgjZqnOkjuiHhUA4x?=
 =?iso-8859-1?Q?jSThghkA9Fzj2tSCGK2dUAp08xU8zwFfudqOk5HKsWZvx/s9f7Qcwaopyt?=
 =?iso-8859-1?Q?MR23S/vmOqI0HDeS8upHZc4SnTMAET4vy43vv3VaZavyfQWw3qtum/AxA8?=
 =?iso-8859-1?Q?ecZOz0bKNrDbfxCygzJR67NVBusecK6znITCS7gqTqWcyqB63OioSwHJ4t?=
 =?iso-8859-1?Q?qcxzWAWb/cNq3gROQeQFVv9mBYMKNl5c60wXqriiznnQIPPXpYvHyBeSl5?=
 =?iso-8859-1?Q?2zVDrTymeR6UrsJ/F0ClbKYn+IYYtUJVl3OFaa5i2n0HSTCz/mfD6sm4bV?=
 =?iso-8859-1?Q?NlWzhFfZybZdBosPOhmxjy55j3zyMn/kcuks46DFEViGyXIdL3sq/K+c9/?=
 =?iso-8859-1?Q?CBBWuEZjRLm45rVgKopQem1Pu70VD/Wgg3ONghAl/AsFxDBnBunbrqagW8?=
 =?iso-8859-1?Q?Xles7cH7Sy++JlrcYWn5tXHmT2y17aOly3O76Pg52Ak6mX7PmxBFJAuqqB?=
 =?iso-8859-1?Q?aTByMfVdVrSRjuvuvGI62axNxDJBqT4cpW3kx7VBJtEj6U60fJO7bzxFPl?=
 =?iso-8859-1?Q?kuz0EfcE/XgBgVuVvfUWC6Zw6cLvL+mUGo4bs7JGBL6J56zmer7KROy7I0?=
 =?iso-8859-1?Q?yBACOLKa/Z34e9yjj1WlVXifQS1G3xa0i4rI4kH0N+3LGbavtj4Q+dnzSG?=
 =?iso-8859-1?Q?3fPaIUMLayyYRfNy/3loArGtz4/phrkt6RByMgWFwEfaj6MeubiNb3t+wv?=
 =?iso-8859-1?Q?lm3mvpkm6A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0869705-c02d-4666-a86f-08da1664ff54
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 18:00:26.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSQtmYovZg2tNJuTbkBvYSmhDfPcEreKF0dEsl5FZQivKB7cWesszfWjwYaTyedg0HWm7TECr4JJOeztOPLAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 31, 2022 at 05:45:39PM +0530, Chatradhi, Naveen Krishna wrote:

...

> > >   	case 0x15:
> > >   		if (pvt->model == 0x30) {
> > I just noticed that families 15h and 16h aren't matching against a model
> > range. I think we should look into that.
> 
> The diff seems fine to me.  Yazen, do you have any inputs on this ?
>

Right, I think this patch is moving the code around correctly. But the code
seems incorrect. So I think it should be fixed if it is indeed incorrect.

> > 
> > ...
> > 
> > > @@ -4142,10 +4012,13 @@ static int probe_one_instance(unsigned int nid)
> > >   	pvt->mc_node_id	= nid;
> > >   	pvt->F3 = F3;
> > > +	pvt->ops = kzalloc(sizeof(*pvt->ops), GFP_KERNEL);
> > > +	if (!pvt->ops)
> > > +		goto err_out;
> > > +
> > This should goto err_enable so that pvt and above can be freed.
> > >   	ret = -ENODEV;
> > > -	fam_type = per_family_init(pvt);
> > > -	if (!fam_type)
> > > -		goto err_enable;
> > > +	if (per_family_init(pvt))
> > > +		goto err_out;
> > > 
> > Same here, but pvt->ops should also be freed at this point too.
> 
> The hw_info_get() is not called till this point, calling goto err_enable
> would unnecessarily call hw_info_put()
> 
> in the exit path.  Better to introduce goto err_pvt and goto err_pvt_ops
> like below Or can i split the function
> 
> by moving the structure allocation part into a separate helper routine ?
> 
> @@ -4101,15 +4101,15 @@ static int probe_one_instance(unsigned int nid)
> 
>         pvt->ops = kzalloc(sizeof(*pvt->ops), GFP_KERNEL);
>         if (!pvt->ops)
> -               goto err_enable;
> +               goto err_pvt;
> 
>         ret = -ENODEV;
>         if (per_family_init(pvt))
> -               goto err_enable;
> +               goto err_pvt_ops;
> 
>         ret = hw_info_get(pvt);
>         if (ret < 0)
> -               goto err_enable;
> +               goto err_pvt_ops;
> 
>         ret = 0;
>         if (!instance_has_memory(pvt)) {
> @@ -4151,6 +4151,11 @@ static int probe_one_instance(unsigned int nid)
> 
>  err_enable:
>         hw_info_put(pvt);
> +
> +err_pvt_ops:
> +       kfree(pvt->ops);
> +
> +err_pvt:
>         kfree(pvt);
>

This seems okay to me.

Thanks,
Yazen 
