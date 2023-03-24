Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D86C870E
	for <lists+linux-edac@lfdr.de>; Fri, 24 Mar 2023 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCXUuk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Mar 2023 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXUuj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Mar 2023 16:50:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412613D7D;
        Fri, 24 Mar 2023 13:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAm1J2kCnP3ZzRmMbqfHwgSFrCIbR2ksx5AF6QYiLzydCoQJ2tI8efkFXaaOprFYNEN5piTn8xRcWxMZlH84/4o6NoFMhbQKLMmjtD8QEZGxjD1co4R3jtR+W+zX03cG/vwNh648Gj71kl4K7Yj7WPS5f0ECGwiOHMee0cJRA0l0aK26LXpazZL/m8kKRQJvelKb9wXX6S59hq02a8MU9U7BZ8EhPVNtbK93yuLQx+/kfGSpTlDi5M8hc3s427BrkfdojP5AHnslo+NN6zkTDyYd51vAo7Cmn6kuXRui1My+6E/c4BRtexcgrYN3rZ6ocAEzdFgLojzXrnGJzfrx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaheDMP4RCXkyxxIkL2DWZsIJzHrsXcY/MrEIczoQ/g=;
 b=UPZXlprXtjXKK6/2jCi/jLWRksQGXY/tSfhlpAHDreBWWQPumPFB0M8Q/romm234qH2Ndh0ES5MzRVILbUb3TLH+zWhw1Tth4XdBVueON/izuKfZgvtW1aZSHz76SX1sb6pSD7+0kSrskqsyx7VoBs9TB+IAQVUo37OuMQ5PTfDgXS65Sho7/yGfyOBNH1DWj/Aivo8ObE7aMqxfz2L23KAUnMXnRvaGTrKMPmhuP+5Dh6h6ci6q+7Agv6R+e+7rsV6qblVWRpatatXT7z1JnNCfvp6V20razIq6l2uQ1R4x8uHqOnkSdobVKmroqE+cppDfUkSepAWvYEKeTh/PDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaheDMP4RCXkyxxIkL2DWZsIJzHrsXcY/MrEIczoQ/g=;
 b=2veH2a0cqECnx8emjDiisiFB/vJcrrhFi+TwYIL0obw3bnyNPOYvkLhAjJ5UUhUcWD6pAB4O4W7NT+6lO0nKy6vhBMWb4GNrKeb+UT5hPy1rVuENhAHfW9EbeGy1Ft0IJM6Sl8zvzwf7dpT1VRDmCYmWuP5UrGeSEfZD/WagPTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 24 Mar
 2023 20:50:36 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 20:50:36 +0000
Date:   Fri, 24 Mar 2023 16:50:31 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kyle-meyer <kyle.meyer@hpe.com>, dimitri.sivanich@hpe.com,
        steve.wahl@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, qiuxu.zhuo@intel.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Message-ID: <ZB4NFzrf09D1J47m@yaz-khff.amd.com>
References: <20230323202158.37937-1-kyle.meyer@hpe.com>
 <20230324004919.GHZBzzj1FzwEZclTCL@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324004919.GHZBzzj1FzwEZclTCL@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dea0483-848b-4d6c-b86b-08db2ca96af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXZFl9KrsPHCJXiBYHQQNuEdwDCDUGTQpb2QZ+oqttgNi9Mde2RC/b18K+4MwgiU0wnvRuqC9/0TjqdPgI9ArDPBV7cnWq+EE6AGS2TtdKOdsmkOJTaiPHexdmUB4b/gaoG9Lm7oE+SAA13cP+ENAUdyuRP9QfxEEHDlW14g1fkCf4KwJ7qq/Tf5qIc1KZFwhdqrM2E3YoRfQnkuUNmUP9jP9gM6ZWz12M03NAXeThnuOHvfvdE2iMFH6K4ypnQZGMYa96QeGdH1wpCxOe0c3eNTmtcouANWV1mB8yQyElFqatvVbKufM/PuUIA7gZH/ultBCErWaF+9GuYHI+6Qbb9/oKV7se0qwx+a9hdr1QG8gZoXxRvEm/4skkBvxMjjIE9h0MDVJkYxuzLHCMCuY0MXdyyd8P17gE6LLeKLcZsQAdkxAhjdjkW2Jxe4hY7BhadHIc3Be6LwBZjcMaWI54LvEI4jv5beGOxIubewpZIUG2PMrmazx9A+jb8kCWna2wQdqDCbiT+oAiRuLYZSkGUJF8NqfRUbfUm5CIML2h5jTk3YRU/1qgBqqmicp7CJ32T0h+uLdM4BtkQzNaJ4mu9g6qrd55lbKvg3bFnEIHKCgaMpGCdefczpIwbe/MEQK1TucQY70jMbaNkckC9WDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(6666004)(6506007)(6512007)(186003)(6486002)(26005)(66946007)(86362001)(8676002)(66556008)(66476007)(8936002)(7416002)(5660300002)(4744005)(4326008)(6916009)(38100700002)(316002)(478600001)(44832011)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5IXQSPtfwfdjoEEjD8siDA3L2teyW+RODssbz1pad2VtaPrvooe1+sIiurds?=
 =?us-ascii?Q?6v6ERBayTwvZ+oyieSk0HioDoSPvoubV66qzZflFwW1q2H/xduTz2GsQS1Ba?=
 =?us-ascii?Q?aAlJ0RQiyz1HP02pLJcNWYBhWbRUFispVynCU9Vv57+VWC/+ooCzWihH5wHx?=
 =?us-ascii?Q?UjjZLxboOOn4DVpa85L6OKZ8RkiAlBYT5XG50YfcCHaoi/ikLf0FZ1y2wWFK?=
 =?us-ascii?Q?YBASHFvBgVnpoVVzBRz5eW/LPaawvDUq7k+BfR/NqN6F2GOEHdFL7MVgPYWR?=
 =?us-ascii?Q?Xvh4AU1JPq0KvfNOg+5NtcsJn8JjQqTTgxY5afnscUeJdAPqCYX19P3vBnkx?=
 =?us-ascii?Q?pRUe5b2Yh1QKlQMfPIgntrw13EBpzqr6MCeBaZJS3b4/2shyEVz27l8lUltl?=
 =?us-ascii?Q?GoTygomjt0l1tJ90xdn5Chuj135cuGq2G5HzV23IdFwIFpzgEiu7KRQEShmw?=
 =?us-ascii?Q?wXxL1294qsuR5iVAyZ6qAkf51Noi5TpF459Tt6N7VWh6NJ5VVORWiIcf+Zrh?=
 =?us-ascii?Q?i9jxlv2n1x4QEq9DbywcPuG/zPedEUCNSJW0s269AkuKznI+Jdtk4Sgo1uPA?=
 =?us-ascii?Q?Sy2o3KcRf4UUw7StwUczdm4iDAK/0Ui6K0afWB1AClThKM0gNAohovCj1X+A?=
 =?us-ascii?Q?GoAYdaw5bUYfriNSdp1SxhSkwXq7Bdclf/TjFcSEXupiegK/VhoEh3rES1Bp?=
 =?us-ascii?Q?40EdNcrySIkbxVyhFYo4R+6MOHqeCfACrCWMr0uYQdfTkjnIlgHOk1jGug9k?=
 =?us-ascii?Q?TPHjfCGY2Uxu55HQEmxVlUVk5kOt2gqAKvfFM+whboflKoE+xkbKEeSDZtce?=
 =?us-ascii?Q?qzGV7D/wj3LjewvJ9vlr/TBvQvu3yVxHs4zZ8xcODSKrh0HIAN/xtinQwmcx?=
 =?us-ascii?Q?wPwmTrSXJ0Xlm2gOXKkSzJdqYOPU+UxB9js7j2G2B9Kp/s6RASfvlgBJqBgO?=
 =?us-ascii?Q?XKgjPDTqCiNEkOIopAt8Of+U/2/DPEWuFi/HOthSonGbrq6TtcHdYz+EWYUz?=
 =?us-ascii?Q?lnrcKTvpvvZjaEPzpQm7Ms3VAIoWJE5dgjwOfxEoXVq0Ue49ANc7IFWLjrTv?=
 =?us-ascii?Q?Q3nI2UBmiNLUTx5z6fDPEjnJIyUkWY3Y1VncT3jptlNYYiBnxCYjdqvreYlN?=
 =?us-ascii?Q?lxp9/sVDEI8O2CViwSed870PzkNSX2WM0GqXmnoHLj/+mvmqtEBUWDGFlbLe?=
 =?us-ascii?Q?DdHax1y7NkG6FN6GvR3/5dc0N94msPijxGKFcu1DS75Eg1ofYkJCWtbUZOYn?=
 =?us-ascii?Q?QRRiGa6kqPF4l3Yfk/eTaEFIbnwJqIZMVe/eE93X8oZ3D0rWGbwk/n8RiYci?=
 =?us-ascii?Q?w1iQxUS/uNVuq2MLnKYud6wvDPOZKT9znDGuQywHv4kjFIJRYloZYn3mdNPG?=
 =?us-ascii?Q?ENNGH1x2zCPWVm+kAL0p8fX1TR6zLwJVLaKiHDFFbXx8RxIty2mo+qkUrrhw?=
 =?us-ascii?Q?mABscvEa0juyKVQN9MDY9QmPNY2/1xknamDroQmzY3DUFb8LDImGGCOcIG5m?=
 =?us-ascii?Q?QDYgPwB6iD4eUSbVufEGh1ipVjhGB4Q5hf9n8/Oxsvu3AmC4GDfAv297kgzW?=
 =?us-ascii?Q?2/7gr0OTpF/r7fvHxA4PHLf2s4QXfNeq4Qu4HitH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dea0483-848b-4d6c-b86b-08db2ca96af0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 20:50:36.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfJ6OPmRfGfWQNJmjZ8dzoM8PxcdPtrCy3DC8OEdH8cq61+N46hdjBOHHRjZekVTb2DhvTzoHqhyIOH2OZWUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 24, 2023 at 01:49:19AM +0100, Borislav Petkov wrote:
...
> 
> Besides, that error collector is used on x86 but it is generic enough so
> that it can be used by other arches. So if anything, it should not be
> exposed in the x86's "machinecheck" hierarchy but somewhere generic.
>

How about "/sys/ras" to collect global RAS interfaces? Maybe it can link to
other directories like "/sys/devices/*" for hardware things like MCA, and
"/sys/kernel/*" for kernel things like CEC.

Thanks,
Yazen
