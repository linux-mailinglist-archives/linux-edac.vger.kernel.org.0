Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80FB6150A1
	for <lists+linux-edac@lfdr.de>; Tue,  1 Nov 2022 18:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKAR2D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Nov 2022 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKAR2C (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Nov 2022 13:28:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33689178B6;
        Tue,  1 Nov 2022 10:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnHjqExa1dnw+EMn7MRE/Gb4JzGzgwKUwe8M7kWuG9ax10HHpxGAvYIR9mJMtVNGmwBFDUJhITeaPI5Uo/J3p11O/yAXbs1z0vJSeogGbEfPgb/aWN7gGNN46wXiLFRvS5OPTJLS5uFO98PEk1rhzHQ/RRGRmE+cyitFQXnHhHjUMH3CQuJx9VLWDKRic+fmiOmVlUdkTBeMs3BBKeIxLXpmyv2sSyh4rU1/7+geyte/VgsUxv/J+mrPR/s3/vUNIzr68TUKnHr8dJNJ8kk34MrAEUvSqaPH1zCIQ20Xt2ldXj+OiJaVgcWu9X4qe7IqcfyHyqeMEuUPGfqqmVhGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2LSUq1i1qnPKZPT6XFS8ixR8GUe6JVQaJKe+M4hRVg=;
 b=RlfybjjD19XQou/PtoUJDhIdSlB9zo0clbRO6ZvLQyPVneWtaRoF1ZzkjaOezdI+m6Z2KEtqFa9MkjBOjYLqYnpJC+rOELS6OaHdPPgyGUocD0hEpret2nwNl8veq6pmhWzhvgJyb7CPcYVMHE16LTvGpYmNTJjBhIQ0l1Ozyu6VFRs9Gp+M2NFU2KBt9bPVCVHNf1eMUbDgnI9y+sZ1U4dtzngQkw2ErSUtyvNY5OzFxdcikzlYtjWoaqfLLyxEK+NyWtKVLv1zF6759DFZcEnqh0sUs+juKR+GHkbrnGAzW23EM3/eh1L9h8y8iIiyIb+E7p8eT97YAMMTRKw3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2LSUq1i1qnPKZPT6XFS8ixR8GUe6JVQaJKe+M4hRVg=;
 b=bx4soWJ8lOoT7uh9SkFHx2MiqY/eY1Xz6zJjMge2QldIXcoaSxmLQF0PNwYDiguMuczdZKPTNWIgB9NKulq/PQjN9r+G5HG/swriEzZRdQYnbKBhQGLs0y9CUb0qboExjO3fCrRF9YmtkRZnKqgCnhoYctl+lEw1fIgBr5IYanc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH0PR12MB5090.namprd12.prod.outlook.com (2603:10b6:610:bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 17:27:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:27:55 +0000
Date:   Tue, 1 Nov 2022 17:27:52 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y2FXGGVmmF1Ae6FG@yaz-fattaah>
References: <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
 <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1cCU9UqGG7nl8cy@zn.tnic>
 <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
 <Y1glfOlFE90SqjV/@zn.tnic>
 <20221025152847.32788cd4@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025152847.32788cd4@gandalf.local.home>
X-ClientProxiedBy: CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH0PR12MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: ba23b57c-3d30-45cd-9953-08dabc2e69b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWfWmXWmFW9cxbOgnPRqoDsFAgneP9biRWHImQlR/67Aj8z6fqYC6wriT51+HX+WPJy5EQyKKpvdxVzeBr3oI88IX8XutzQYxhNVn7fCz2tOqJVxPY+TWoD6ushnmM2EkyWUpR2tOj56kH6tR4MZ0DHZpBS541b06WL1v+rw3XQCtiFNkM2F4oR5a6kKgjj9Dpbiv4bxStXPfLrKA+xTH8lECsqcfZqJyvW66asp8Lndwn5SieRdceR93j59p+yRda+nNJg5oZkIlLP6MCnBhPH56S9fhdhEPzYuZMJ00kLcl8RQITWa0goB+KFGPxQeHK2vdvACPXzOIkqHQXpFo0Uz7FDsIFafhq35RRZmJLZpPjk8VLmCelW1DcCZoT7GEFhfk89YLBFso3fo+oK/pUy22V+R3Fiw532SCiUoQvgiXCI6rpM8vZC6pt7gMbo2UzkcM91fa+aI1CeT/G++80OufbosyfwxC5aniaGnK2TFs+CpH/NZ9+aw+u8aP1hWDLTX4hsEQkWQtddLYBXVyrzKdPwxU0OCqvz3pLVXoQQ6nUpnHjRUIqkmn4c120UyNaswBrEvNu1bNmWax5Pf+WQcE4pqHQhJagvArAcKJEkJHQU+HHngSxUM720RlPzyQdaxPMCGXag4wv9s/v9cdTCqWF50JIL/MlPlReFhwXAPr6cePVav5S/DUz01P6lQq4aSlF0GAVlgOd3f4liGxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(66556008)(38100700002)(86362001)(478600001)(54906003)(558084003)(316002)(6506007)(33716001)(4326008)(6666004)(66476007)(66946007)(8936002)(8676002)(5660300002)(186003)(44832011)(6916009)(6486002)(2906002)(9686003)(26005)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCJOg0dwxujZd+AUrk3p/IelUtmCZ/h8HloETU2J95QYxperujI67AJT8YM8?=
 =?us-ascii?Q?Cd/7Zeu7JRrUOL7AcAj40VSONQ5UntAnomtC7VAmKk9aNeShVqUwsmkw3PoX?=
 =?us-ascii?Q?oRqx+D5WcN+7IPtDhOc04o3RYCmZsw5qnYIEXxU7WQIsxj/oRZthF69IBbDs?=
 =?us-ascii?Q?lc8o1G7Wu8SmMFilqkLgseQ141c7JHJSfKJ4aZCkvhQSCYHa8bE75ap8LPHY?=
 =?us-ascii?Q?eLiosWpFwOgFERdKbUTGkQs7ogzr7ieZWTT629eYK0WhD3di6So0Qn/B6kNj?=
 =?us-ascii?Q?kXA9jXo++w91fHu+b5dmcVXV2KQBJi/tVEegz1eg8ns/4DJ2lmYkNt6BQOHs?=
 =?us-ascii?Q?ml7cJvSjABQ9rcfLnyv1YxixJPaSMDmE1S7/O0Ov98er8Mv3IFdDujJyBJlJ?=
 =?us-ascii?Q?0NNu8DZk4PF4aVuP3Lb+UjzSYFu3iS0iHD4Bx6OIO1kXi43AoaGo6ARNofsG?=
 =?us-ascii?Q?VIIYq/n7xC4382VxHOOXdpi7xF07MvrYqDue2K1H4yW6iseoQMXtTRJsHmLZ?=
 =?us-ascii?Q?IG4putGCfVhh1jUapi4WVZ5U8G98vKOi9HvwGAhFNlGfqN5eXk9GF45nRPKX?=
 =?us-ascii?Q?5DDX86vqi3dJyVA0MVFz57kRmuAT8BBb7eHL1CNn8mhU7Flcsb82OIOjGQM5?=
 =?us-ascii?Q?Q72ecall9Jw8zY+VRKIcB18ypzOIoGJZ6eewZBPNVpw6yhW4qHGavl0Lex9x?=
 =?us-ascii?Q?5j8DIs0CSb1L8UT16jgK2wEG8nmKw9MbwYEzJ1AmD7FjGo7BHiDLl87cKliE?=
 =?us-ascii?Q?8IPydySRi+lOtF+iR70adQyNwVy9gfJG9Y9o6sop0JrnHnhw3/Fg8o8CF2fM?=
 =?us-ascii?Q?a1DnjkDDDbjiYIdvaR4Y4jjOYETEBseio1vq99yIGn/NgJkPj+misXRMgO9i?=
 =?us-ascii?Q?OAzB3xv07CMp1AUIk5rGv87cVVqjmv7MJ/eNybf7gsxbfmd10vn4YJ+bjceJ?=
 =?us-ascii?Q?jStBc1ghOZs7+EjfpP8jel2xBYbBquVnHNAqiDs+jEBe+pH0bMBPCX2sTZW7?=
 =?us-ascii?Q?PulObCINPS0iZiu5Led5830O/Y99hbQHd0WOCxauC/0zrLANPgLqsXRl4BW2?=
 =?us-ascii?Q?J5K4BQglz4+5ugWnRf+F0DADpbDEXP02u/Km0QzM0sgCCpmZm086cy8yoo4o?=
 =?us-ascii?Q?55JXaIyjZc78fmV2voibcqDGp8ppcJG5t/A4WYv1lBu/V8LJtzTZRsS1iPck?=
 =?us-ascii?Q?vWkG72pkphpgn9C2xCcD7xNHoj48c6GNmuoXqUqKo8YQ7RT2m7krHOnkdyyi?=
 =?us-ascii?Q?mb63P+mOHMX5YlImEMnxStVMM4vBW3LxmkOVZJIN4KEbDorf59IsXD8DeiPf?=
 =?us-ascii?Q?UBGxuo5xMRy9xpPmJZwUaHXDkxn0T7su6RSykm+meJzBQ8ZvhBzT9JGYb+ln?=
 =?us-ascii?Q?ABVYgrqA+xfDIwZY6CRT66FsR8SaDjeGFecE1TDAx5WODIdQbOzxBfeIzNOT?=
 =?us-ascii?Q?mPkWxCy/utuLfV0FFpv+Kps/hzDe0tyKrk/xbFtk+eaNc7hkKbolBsccG421?=
 =?us-ascii?Q?HoFao9CGhpJB4XucrlUcp3deYum//q17H+OA+gRDNREvoFy2HI8KZwdAA99Q?=
 =?us-ascii?Q?GJi9P1svfDs5y1bbVuZMftoWP+igQiu7ZkNV98A3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba23b57c-3d30-45cd-9953-08dabc2e69b6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 17:27:55.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4AtDA8GEdyRULJx7JbT3/ExBFp/ZPot7d/6vzXTrbW0gkW0ar6P27f6Xg37FqKNDM9nrvR5GPtIr/4dOcFIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 25, 2022 at 03:28:47PM -0400, Steven Rostedt wrote:

...

> With libtracefs and libtraceevent, process trace events is so much easier
> than it use to be!
>

Thanks Boris and Steve!

I'll start digging into this.

-Yazen
